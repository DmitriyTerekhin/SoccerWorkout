//
//  SignInParser.swift
//  Workout
//
//  Created by Ju on 19.02.2024.
//

import Foundation
import SwiftyJSON

class AuthParser: IParser {
    
    typealias Model = AuthModel
    
    func parse(json: JSON) -> Model? {
        let dataJson = json
        return AuthModel(refreshToken: dataJson["refresh_token"].stringValue,
                         accessToken: dataJson["access_token"].stringValue,
                         idToken: dataJson["id_token"].stringValue,
                         expiresIn: dataJson["expires_in"].stringValue,
                         tokenType: dataJson["token_type"].stringValue)
    }
}
