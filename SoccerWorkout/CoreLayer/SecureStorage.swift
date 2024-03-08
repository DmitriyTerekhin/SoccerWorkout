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
    func saveUserId(id: String)
    func getUserId() -> String?
    func saveUserSkill(skill: Skill)
    func getUserSkill() -> Skill?
    func saveUserPoints(point: Int)
    func getUserPoints() -> Int
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
        case userId
        case userSkill
        case userPoints
        
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
    func saveUserId(id: String) {
        keychain.set(id, forKey: Constants.userId.title)
    }
    func getUserId() -> String? {
        keychain.get(Constants.userId.title)
    }
    func saveUserSkill(skill: Skill) {
        keychain.set(skill.rawValue, forKey: Constants.userSkill.title)
    }
    func getUserSkill() -> Skill? {
        return Skill(rawValue: keychain.get(Constants.userSkill.title) ?? "")
    }
    func saveUserPoints(point: Int) {
        keychain.set(String(point), forKey: Constants.userPoints.title)
    }
    func getUserPoints() -> Int {
        Int(keychain.get(Constants.userPoints.title) ?? "0") ?? 0
    }
}
