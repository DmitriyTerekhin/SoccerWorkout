//
//  AppInfoService.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

typealias FinishedCompletionHandler = (Bool) -> Void

protocol ISensentiveInfoService: AnyObject {
    func saveAppleToken(token: String)
    func saveNotificationToken(token: String)
    func deleteAllInfo(completionBlock: FinishedCompletionHandler)
    func isUserInApp() -> Bool
    func getAppleToken() -> String?
    func wasPushAsked() -> Bool
    func changeAskPushValue()
}

class AppInfoService: ISensentiveInfoService {
    
    private let secureStorage: ISecureStorage
    private let appSettingsStorage: IUserDefaultsSettings

    init(
        secureStorage: ISecureStorage,
        userInfoStorage: IUserDefaultsSettings
    ) {
        self.secureStorage = secureStorage
        self.appSettingsStorage = userInfoStorage
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
    
    private func changeUserInAppValue(isUserInApp: Bool) {
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
}
