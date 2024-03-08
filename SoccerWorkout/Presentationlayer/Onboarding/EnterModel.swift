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

struct AuthDTO {
    var level: Int
    var userId: String
    var token: String?
}
