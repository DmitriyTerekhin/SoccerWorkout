//
//  EnterModel.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 29.07.2023.
//

import Foundation

enum EnterLogicType {
    case notification
    case signIn
}

struct AuthModel {
    let refreshToken: String
    let accessToken: String
    let idToken: String
    let expiresIn: String
    let tokenType: String
}

class AuthDTO {
    var level: Int
    var userId: String
    var token: String?
    var goal: Int?
    
    init(level: Int, userId: String, token: String? = nil, goal: Int? = nil) {
        self.level = level
        self.userId = userId
        self.token = token
        self.goal = goal
    }
}
