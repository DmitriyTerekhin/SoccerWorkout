//
//  SettingsModels.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import Foundation

enum SettingsTypes {
    case termsOfUse
    case privacy
    case rateUs
    case delete
    
    var title: String {
        switch self {
        case .termsOfUse:
            return "Terms of use"
        case .privacy:
            return "Privacy policy"
        case .rateUs:
            return "Rate Us"
        case .delete:
            return "Delete Account"
        }
    }
    
    var logoImageString: String {
        switch self {
        case .delete:
            return "Close"
        default:
            return "ArrowRight"
        }
    }
}
