//
//  SettingsPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import Foundation

protocol ISettingPresenter: AnyObject {
    func settingDidSelect(_ type: SettingsTypes)
}
protocol ISettingsView: AnyObject {}

class SettingsPresenter: ISettingPresenter {
    unowned var view: ISettingsView!
    
    func attachView(_ view: ISettingsView) {
        self.view = view
    }
    
    func settingDidSelect(_ type: SettingsTypes) {
        print(type)
    }
}
