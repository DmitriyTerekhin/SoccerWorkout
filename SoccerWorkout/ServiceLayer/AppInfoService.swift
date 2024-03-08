//
//  AppInfoService.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

typealias FinishedCompletionHandler = (Bool) -> Void

protocol ISensentiveInfoService: AnyObject {
    var userSkill: Skill { get }
    var userId: String { get }
    func saveUserId(id: String)
    func saveUserSkill(skill: Skill)
    func saveAppleToken(token: String)
    func saveNotificationToken(token: String)
    func deleteAllInfo(completionBlock: FinishedCompletionHandler)
    func isUserInApp() -> Bool
    func getAppleToken() -> String?
    func wasPushAsked() -> Bool
    func changeAskPushValue()
    func changeUserInAppValue(isUserInApp: Bool)
    func saveUserPoints(_ points: Int)
    func getUserPoints() -> Int
}

class AppInfoService: ISensentiveInfoService {
    
    private let secureStorage: ISecureStorage
    private let appSettingsStorage: IUserDefaultsSettings
    
    var userSkill: Skill {
        return secureStorage.getUserSkill() ?? .beginner
    }
    var userId: String {
        return secureStorage.getUserId() ?? ""
    }

    init(
        secureStorage: ISecureStorage,
        userInfoStorage: IUserDefaultsSettings
    ) {
        self.secureStorage = secureStorage
        self.appSettingsStorage = userInfoStorage
    }
    
    func saveUserId(id: String) {
        secureStorage.saveUserId(id: id)
    }
    func saveUserSkill(skill: Skill) {
        secureStorage.saveUserSkill(skill: skill)
    }
    
    func saveAppleToken(token: String) {
        secureStorage.saveAppleToken(token: token)
    }
    
    func deleteAllInfo(completionBlock: (Bool) -> ()) {
        changeUserInAppValue(isUserInApp: false)
        secureStorage.deleteAllInfo(completionBlock: completionBlock)
    }
    
    func isUserInApp() -> Bool {
        return appSettingsStorage.getUserInAppValue()
    }
    
    func getAppleToken() -> String? {
        secureStorage.getAppleToken()
    }
    
    func changeUserInAppValue(isUserInApp: Bool) {
        appSettingsStorage.changeUserInAppValue(on: isUserInApp)
    }
    
    func saveNotificationToken(token: String) {
        secureStorage.savePushToken(token: token)
    }
    
    func wasPushAsked() -> Bool {
        appSettingsStorage.getAskPushValue()
    }
    
    func changeAskPushValue() {
        appSettingsStorage.changePushAsked(value: true)
    }
    func saveUserPoints(_ points: Int) {
        secureStorage.saveUserPoints(point: points)
    }
    func getUserPoints() -> Int {
        secureStorage.getUserPoints()
    }
}
