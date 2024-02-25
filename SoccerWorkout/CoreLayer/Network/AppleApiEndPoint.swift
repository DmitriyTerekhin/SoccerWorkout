//
//  AppleApiEndPoint.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation
import Alamofire

enum AppleApiEndPoint: ApiConfiguration {
    case revokeAppleToken(clientId: String, clientSecret: String, clientToken: String)
    
    var method: HTTPMethod {
        switch self {
        case .revokeAppleToken:
            return .post
        }
    }

    var path: String {
        switch self {
        case .revokeAppleToken:
            return "/auth/revoke"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .revokeAppleToken(let clientId, clientSecret: let clientSecret, clientToken: let token):
            return [
                ApiConstants.APIParameterKey.clientId: clientId,
                ApiConstants.APIParameterKey.clientSecret: clientSecret,
                ApiConstants.APIParameterKey.token: token,
                ApiConstants.APIParameterKey.tokenType: "access_token"
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return HTTPHeaders(
                [   "accept":"application/json",
                    "Content-Type":"application/x-www-form-urlencoded"
                ]
            )
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: ApiConstants.URL.appleBase.appending(path).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        if let parameters = parameters {
            let options = JSONSerialization.WritingOptions()
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: options)
        }
        return urlRequest
    }
}
