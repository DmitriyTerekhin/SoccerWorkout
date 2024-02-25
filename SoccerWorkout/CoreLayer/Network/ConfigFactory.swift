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
    static func savePushToken(token: String) -> ApiRequestConfig<SavePushTokenParser> {
        return ApiRequestConfig(endPoint: WorkoutEndPoint.savePushToken(token: token), parser: SavePushTokenParser())
    }
    
    static func revokeAppleToken(token: String, clientId: String, clientSecret: String) -> ApiRequestConfig<SucceedParser> {
        return ApiRequestConfig(endPoint: AppleApiEndPoint.revokeAppleToken(clientId: clientId,
                                                                            clientSecret: clientSecret,
                                                                            clientToken: token),
                                parser: SucceedParser())
    }
}
