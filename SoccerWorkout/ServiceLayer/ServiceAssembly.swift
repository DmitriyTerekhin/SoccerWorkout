//
//  ServiceAssembly.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

protocol IServiceAssembly {
    var networkService: INetworkService { get }
//    var databaseService: IDatabaseService { get }
    var userInfoService: ISensentiveInfoService { get }
}

class ServiceAssembly: IServiceAssembly {
    
    private let coreAssembly: ICoreAssembly
    
    init(coreAssembly: ICoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    lazy var networkService: INetworkService = NetworkService(requestSender: coreAssembly.requestSender)
//    lazy var databaseService: IDatabaseService = DatabaseService(db: coreAssembly.storage,
//                                                                 coreDataStack: CoreDataStack.shared)
    lazy var userInfoService: ISensentiveInfoService = AppInfoService(secureStorage: coreAssembly.secureStorage,
                                                                          userInfoStorage: coreAssembly.appSettings)
}
