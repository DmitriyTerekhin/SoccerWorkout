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
    case delete(token: String)
    
    var method: HTTPMethod {
        switch self {
        case .signInWithApple, .savePushToken:
            return .post
        case .delete:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .signInWithApple:
            return "/sign-in-with-apple"
        case .savePushToken:
            return "/savePushToken"
        case .delete:
            return "/deleteMe"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .savePushToken(let token):
            return ["token": token]
        case .signInWithApple(let token):
            return ["authorization_code": token]
        case .delete(let token):
            return ["token": token]
        default:
            return [:]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
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
        switch self {
        case .savePushToken, .signInWithApple, .delete:
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let value = value as? String {
                        items.append(URLQueryItem(name: key, value: value))
                    }
                }
            }
        default:
            break
        }
        urlComp.queryItems = items
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        return urlRequest
    }
    
}
