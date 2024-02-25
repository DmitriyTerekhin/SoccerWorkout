//
//  RootAssembly.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

class RootAssembly {
    lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(serviceAssembly: serviceAssembly)
    lazy var serviceAssembly: IServiceAssembly = ServiceAssembly(coreAssembly: coreAssembly)
    lazy var coreAssembly: ICoreAssembly = CoreAssembly()
}
