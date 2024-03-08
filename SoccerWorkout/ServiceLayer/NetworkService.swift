//
//  NetworkService.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation
import SwiftyJSON

protocol INetworkService {
    func loadHistory(userId: String, completion: @escaping(Result<[WorkoutDTO], NetworkError>) -> Void)
    func makeAuth(token: String, completion: @escaping(Result<AuthModel, NetworkError>) -> Void)
    func sendPushToken(token: String)
    func loadWorkoutList(userId: String, completion: @escaping(Result<[WorkoutDTO], NetworkError>) -> Void)
    func deleteProfile(token: String, completion: @escaping(Result<Bool, NetworkError>) -> Void)
    func revokeAppleToken(token: String, clientSecret: String, clientId: String, completionHandler: @escaping(Result<Bool, NetworkError>) -> Void)
    func addWorkOutHistory(userId: String,
                           workoutId: Int,
                           workoutDate: String,
                           completionHandler: @escaping (Result<Int, NetworkError>) -> Void)
    func createUser(userId: String,
                    level: Int,
                    pushToken: String?,
                    completion: @escaping(Result<AuthDTO, NetworkError>) -> Void)
    func loadAvailableWorkouts(userId: String, completion: @escaping(Result<[WorkoutDTO], NetworkError>) -> Void)
}

class NetworkService: INetworkService {
    
    let requestSender: IRequestSender
     
     init(requestSender: IRequestSender) {
         self.requestSender = requestSender
     }
    
    func loadHistory(userId: String, completion: @escaping(Result<[WorkoutDTO], NetworkError>) -> Void) {
        requestSender.send(requestConfig: ConfigFactory.loadHistory(userId: userId),
                           completionHandler: completion)
    }
    
    func loadWorkoutList(userId: String, completion: @escaping(Result<[WorkoutDTO], NetworkError>) -> Void) {
        requestSender.send(
            requestConfig: ConfigFactory.loadWorkoutsList(userId: userId),
                           completionHandler: completion)
    }
    
    func createUser(userId: String,
                    level: Int,
                    pushToken: String?,
                    completion: @escaping(Result<AuthDTO, NetworkError>) -> Void) {
        requestSender.send(requestConfig: ConfigFactory.createUser(authDTO:
                                                                    AuthDTO(level: level,
                                                                            userId: userId,
                                                                            token: pushToken
                                                                           )
                                                                  ), completionHandler: completion)
    }
    
    func makeAuth(token: String, completion: @escaping (Result<AuthModel, NetworkError>) -> Void) {
        requestSender.send(requestConfig: ConfigFactory.auth(token: token), completionHandler: completion)
    }
    
    func sendPushToken(token: String) {
        requestSender.send(requestConfig: ConfigFactory.savePushToken(token: token)) { _ in }
    }
    
    func deleteProfile(token: String, completion: @escaping(Result<Bool, NetworkError>) -> Void) {
        requestSender.send(requestConfig: ConfigFactory.deleteProfile(token: token), completionHandler: completion)
    }
    
    func revokeAppleToken(token: String, clientSecret: String, clientId: String, completionHandler: @escaping(Result<Bool, NetworkError>) -> Void) {
        requestSender.send(requestConfig: ConfigFactory.revokeAppleToken(token: token,
                                                                         clientId: clientId,
                                                                         clientSecret: clientSecret),
                           completionHandler: completionHandler)
    }
    
    func addWorkOutHistory(userId: String, workoutId: Int, workoutDate: String, completionHandler: @escaping (Result<Int, NetworkError>) -> Void) {
        requestSender.send(requestConfig: ConfigFactory.addHistory(userId: userId,
                                                                   workoutId: workoutId,
                                                                   workoutDate: workoutDate),
                           completionHandler: completionHandler)
    }
    
    func loadAvailableWorkouts(userId: String, completion: @escaping (Result<[WorkoutDTO], NetworkError>) -> Void) {
        requestSender.send(
            requestConfig: ConfigFactory.loadAvailableWorkouts(userId: userId),
                           completionHandler: completion)
    }
}
