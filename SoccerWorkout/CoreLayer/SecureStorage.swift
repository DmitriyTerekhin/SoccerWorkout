//
//  SecureStorage.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation
import KeychainSwift

protocol ISecureStorage {
    func premiumIsActive() -> Bool
    func savePremium()
    func saveAppleAccessToken(token: String)
    func saveAppleToken(token: String)
    func saveAppleRefreshToken(token: String)
    func getAppleToken() -> String?
    func savePushToken(token: String)
    func deleteAllInfo(completionBlock: FinishedCompletionHandler)
}

class SecureStorage: ISecureStorage {
    
    private let keychain = KeychainSwift()
    static let shared = SecureStorage()
    
    private init () {}
    
    private enum Constants: String {
        case premium
        case appleAccessToken
        case appleRefreshToken
        case pushToken
        
        var title: String {
            return self.rawValue
        }
    }
    
    func deleteAllInfo(completionBlock: FinishedCompletionHandler) {
        completionBlock(keychain.clear())
    }
    
    func savePremium() {
        keychain.set(true, forKey: Constants.premium.title)
    }
    
    func premiumIsActive() -> Bool {
        return keychain.getBool(Constants.premium.title) ?? false
    }
    
    func saveAppleAccessToken(token: String) {
        keychain.set(token, forKey: Constants.appleAccessToken.title)
    }
    func saveAppleRefreshToken(token: String) {
        keychain.set(token, forKey: Constants.appleRefreshToken.title)
    }
    func saveAppleToken(token: String) {
        keychain.set(token, forKey: Constants.appleAccessToken.title)
    }
    func getAppleToken() -> String? {
        keychain.get(Constants.appleAccessToken.title)
    }
    func savePushToken(token: String) {
        keychain.set(token, forKey: Constants.pushToken.title)
    }
}
