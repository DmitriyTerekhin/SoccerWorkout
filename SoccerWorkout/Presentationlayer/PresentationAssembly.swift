//
//  PresentationAssembly.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

protocol IPresentationAssembly {
    func enterScreen() -> EnterViewController
    func workoutScreen() -> WorkoutViewController
    func homeScreen() -> HomeViewController
    func settingsScreen() -> SettingsViewController
    func tabBarViewController() -> CustomTabBarController
    func chooseSkillScreen() -> ChooseSkillViewController 
    func changeRootViewController(on viewController: UIViewController)
    func getStartScreen() -> UIViewController
    func webViewController(site: String, title: String?) -> WebViewViewController
    func workoutDetailScreen() -> ConfigureWorkoutViewController
    func playWorkoutScreen() -> PlayWorkoutViewController
}

class PresentationAssembly: IPresentationAssembly {
    func webViewController(site: String, title: String?) -> WebViewViewController {
        return WebViewViewController(site: site, title: title)
    }
    
    func enterScreen() -> EnterViewController {
        return EnterViewController(presentationAssemmbly: self,
                                   networkService: serviceAssembly.networkService,
                                   userInfoService: serviceAssembly.userInfoService)
    }
    
    func chooseSkillScreen() -> ChooseSkillViewController {
        return ChooseSkillViewController(presentationAssembly: self)
    }
    
    func workoutScreen() -> WorkoutViewController {
        WorkoutViewController(presenter: WorkoutPresenter(networkService: serviceAssembly.networkService))
//        WorkoutViewController(presenter: WorkoutPresenter(databaseService: serviceAssembly.databaseService))
    }
    
    func playWorkoutScreen() -> PlayWorkoutViewController {
        return PlayWorkoutViewController(presenter: PlayWorkoutPresenter(),
                                         presentationAssemly: self)
    }
    
    func homeScreen() -> HomeViewController {
        HomeViewController(presenter: HomePresenter(networkService: serviceAssembly.networkService), presentationAssembly: self)
//        return ProfileViewController(presenter: ProfilePresenter(
//            networkService: serviceAssembly.networkService,
//            userInfoService: serviceAssembly.userInfoService,
//            presentationAssembly: self,
//            databaseService: serviceAssembly.databaseService),
//                                     presentationAssembly: self)
    }
    
    func settingsScreen() -> SettingsViewController {
        return SettingsViewController(presenter: SettingsPresenter())
    }
    
    private let serviceAssembly: IServiceAssembly
    
    init(serviceAssembly: IServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func tabBarViewController() -> CustomTabBarController {
        return CustomTabBarController(tabBar: CustomTabBar(presentationAssembly: self))
    }
    
    func getStartScreen() -> UIViewController {
        guard
            serviceAssembly.userInfoService.isUserInApp(),
            serviceAssembly.userInfoService.getAppleToken() != nil
        else {
            return enterScreen()
        }
        
        return tabBarViewController()
    }
    
    func workoutDetailScreen() -> ConfigureWorkoutViewController {
        return ConfigureWorkoutViewController(presenter: ConfigureWorkoutPresenter())
    }
    
    func changeRootViewController(on viewController: UIViewController) {
        if #available(iOS 13.0, *) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController)
        } else {
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(viewController)
        }
    }
}
