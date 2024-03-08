//
//  WorkoutEndPoint.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation
import Alamofire

enum WorkoutEndPoint: ApiConfiguration {
    
    case savePushToken(token: String)
    case signInWithApple(token: String)
    case createUser(userId: String, level: Int, pushToken: String)
    case getAllWorkouts
    case getHistory(userId: String)
    case delete(token: String)
    case addWorkoutHistory(userId: String, workoutId: Int, workoutDate: String)
    case getAvailableWorkouts(userId: String)
    
    var method: HTTPMethod {
        switch self {
        case .signInWithApple, .savePushToken, .createUser, .addWorkoutHistory:
            return .post
        case .getAllWorkouts, .getHistory, .getAvailableWorkouts:
            return .get
        case .delete:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getAvailableWorkouts(let userId):
            return "/api/v1/users/\(userId)/available_workouts/"
        case .getHistory(let userId):
            return "/api/v1/users/\(userId)/workout_history/"
        case .signInWithApple:
            return "/sign-in-with-apple"
        case .savePushToken:
            return "/savePushToken"
        case .createUser:
            return "/api/v1/users"
        case .getAllWorkouts:
            return "/workouts/"
        case .delete(let userId):
            return "/api/v1/users/\(userId)"
        case .addWorkoutHistory(let userId, _, _):
            return "/api/v1/users/\(userId)/workout_history/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .savePushToken(let token):
            return ["token": token]
        case .signInWithApple(let token):
            return ["authorization_code": token]
        case .addWorkoutHistory(_, let id, let date):
            return [
                "workout_id": id,
                "workout_date": date,
                "workout_details": ""
            ]
        case .createUser(let userId, let level, let pushToken):
            return [
                "id": userId,
                "level": level,
                "token": pushToken
            ]
        default:
            return [:]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getAllWorkouts, .getAvailableWorkouts:
            return HTTPHeaders(
              [
                "accept": "application/json"
              ]
            )
        case .createUser, .addWorkoutHistory:
            return HTTPHeaders(
              [
                "accept": "application/json",
                "Content-Type": "application/json"
              ]
            )
          default:
              return HTTPHeaders(
                [
                    "accept":"application/json",
                    "content-type": "application/x-www-form-urlencoded"
                ]
              )
          }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlComp = NSURLComponents(string: ApiConstants.URL.base.appending(path).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
        var items = [URLQueryItem]()
        var jsonBodyParams: Data?
        switch self {
        case .savePushToken, .signInWithApple, .delete:
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let value = value as? String {
                        items.append(URLQueryItem(name: key, value: value))
                    }
                }
            }
        case .createUser, .addWorkoutHistory:
            do {
                let options = JSONSerialization.WritingOptions()
                jsonBodyParams = try JSONSerialization.data(withJSONObject: parameters ?? [:], options: options)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        default: break
        }
        urlComp.queryItems = items
        print(urlComp.url!)
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = method.rawValue
        if let jsonParams = jsonBodyParams {
            urlRequest.httpBody = jsonParams
        }
        urlRequest.headers = headers
        return urlRequest
    }
    
}
