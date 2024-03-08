//
//  CoreAssembly.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

protocol ICoreAssembly {
    var secureStorage: ISecureStorage { get }
    var appSettings: IUserDefaultsSettings { get }
    var requestSender: IRequestSender { get }
    var storage: IStorageManager { get }
}

class CoreAssembly: ICoreAssembly {
    
    init() {}
    
    lazy var secureStorage: ISecureStorage = SecureStorage.shared
    lazy var appSettings: IUserDefaultsSettings = UserDefaultsStorage.shared
    lazy var storage: IStorageManager = CoreDataManager.shared
    lazy var requestSender: IRequestSender = RequestSender()
}
