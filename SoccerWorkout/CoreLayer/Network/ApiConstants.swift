//
//  ApiConstants.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

struct ApiConstants {
    
    struct URL {
        static let privacyBase = "https://kb.bvdapp.com"
        static let appleBase = "https://appleid.apple.com"
        static let base = "https://www.b-app.xyz"
        
    }
    
    struct APIParameterKey {
        static let token = "token"
        static let ident = "identity"
        static let pushToken = "device_id"
        static let accessToken = "access_token"
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        static let tokenType = "token_type_hint"
    }
}
