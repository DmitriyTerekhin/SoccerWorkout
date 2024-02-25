//
//  CustomTabItem.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 25.07.2023.
//

import UIKit

enum CustomTabItemType {
    case Home
    case History
    case Settings
}

struct CustomTabItem: Equatable {
    let type: CustomTabItemType
    let viewController: UINavigationController
    
    var icon: UIImage? {
        type.icon
    }
    
    var selectedIcon: UIImage? {
        type.selectedIcon
    }
    
    init(type: CustomTabItemType, viewController: UIViewController) {
        self.type = type
        let navVC: UINavigationController = UINavigationController(rootViewController: viewController)
        self.viewController = navVC
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.type == rhs.type
    }
}

extension CustomTabItemType {

    var icon: UIImage? {
        switch self {
        case .Home:
            return UIImage(named: "Home")
        case .History:
            return UIImage(named: "List")
        case .Settings:
            return UIImage(named: "Setting")
        }
    }

    var selectedIcon: UIImage? {
        switch self {
        case .Home:
            return UIImage(named: "Home_selected")
        case .History:
            return UIImage(named: "List_selected")
        case .Settings:
            return UIImage(named: "Setting_selected")
        }
    }
    
    var title: String {
        switch self {
        case .Home:
            return "Home"
        case .History:
            return "Workout"
        case .Settings:
            return "Settings"
        }
    }
}
