//
//  NetworkService.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

protocol INetworkService {
    func loadHistory()
    func loadWorkoutList()
    func makeAuth(token: String, completion: @escaping(Result<AuthModel, NetworkError>) -> Void)
    func sendPushToken(token: String)
    func deleteProfile(token: String, completion: @escaping(Result<Bool, NetworkError>) -> Void)
    func revokeAppleToken(token: String, clientSecret: String, clientId: String, completionHandler: @escaping(Result<Bool, NetworkError>) -> Void)
}

class NetworkService: INetworkService {
    
    let requestSender: IRequestSender
     
     init(requestSender: IRequestSender) {
         self.requestSender = requestSender
     }
    
    func loadHistory() {
        // Loading
    }
    
    func loadWorkoutList() {
        // loading
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
}
