//
//  ConfigFactory.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

struct ConfigFactory {
    static func deleteProfile(token: String) -> ApiRequestConfig<DeleteParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.delete(token: token), parser: DeleteParser())
    }
    static func auth(token: String) -> ApiRequestConfig<AuthParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.signInWithApple(token: token), parser: AuthParser())
    }
    static func createUser(authDTO: AuthDTO) -> ApiRequestConfig<CreateUserParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.createUser(userId: authDTO.userId,
                                                                     level: authDTO.level,
                                                                     pushToken: authDTO.token ?? "",
                                                                     goal: authDTO.goal),
                                parser: CreateUserParser())
    }
    static func loadWorkoutsList(userId: String) -> ApiRequestConfig<WorkoutListParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.getAllWorkouts,
                                parser: WorkoutListParser())
    }
    static func savePushToken(token: String) -> ApiRequestConfig<SavePushTokenParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.savePushToken(token: token), parser: SavePushTokenParser())
    }
    static func loadHistory(userId: String) -> ApiRequestConfig<WorkoutListParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.getHistory(userId: userId), parser: WorkoutListParser(isHistoryList: true))
    }
    static func addHistory(userId: String, workoutId: Int, workoutDate: String) -> ApiRequestConfig<HistoryParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.addWorkoutHistory(userId: userId,
                                                                            workoutId: workoutId,
                                                                            workoutDate: workoutDate),
                                parser: HistoryParser())
    }
    static func loadAvailableWorkouts(userId: String) -> ApiRequestConfig<WorkoutListParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.getAvailableWorkouts(userId: userId), parser: WorkoutListParser())
    }
    static func revokeAppleToken(token: String, clientId: String, clientSecret: String) -> ApiRequestConfig<SucceedParser> {
        return ApiRequestConfig(endPoint: AppleApiEndPoint.revokeAppleToken(clientId: clientId,
                                                                            clientSecret: clientSecret,
                                                                            clientToken: token),
                                parser: SucceedParser())
    }
}
