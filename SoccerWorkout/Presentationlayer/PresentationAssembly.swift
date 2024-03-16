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
    func chooseSkillScreen(userId: String) -> ChooseSkillViewController
    func changeRootViewController(on viewController: UIViewController)
    func getStartScreen() -> UIViewController
    func webViewController(site: String, title: String?) -> WebViewViewController
    func workoutDetailScreen(workout: WorkoutDTO,
                             delegate: WorkoutDetailDelegate?) -> ConfigureWorkoutViewController
    func playWorkoutScreen(workoutDTO: WorkoutDTO) -> PlayWorkoutViewController
    func chooseGoalScreen(viewState: ChooseGoalViewState) -> ChooseGoalLevelViewController
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
    
    func chooseSkillScreen(userId: String) -> ChooseSkillViewController {
        return ChooseSkillViewController(
            presentationAssembly: self,
            presenter: SkillRegistrationPresenter(userId: userId,
                                                  networkService: serviceAssembly.networkService,
                                                  userInfoService: serviceAssembly.userInfoService,
                                                  databaseService: serviceAssembly.databaseService
                                                 ))
    }
    
    func workoutScreen() -> WorkoutViewController {
        WorkoutViewController(
            presenter: WorkoutPresenter(networkService: serviceAssembly.networkService,
                                        userInfoService: serviceAssembly.userInfoService,
                                        databaseService: serviceAssembly.databaseService
                                       ))
    }
    
    func playWorkoutScreen(workoutDTO: WorkoutDTO) -> PlayWorkoutViewController {
        return PlayWorkoutViewController(presenter: PlayWorkoutPresenter(
            infoService: serviceAssembly.userInfoService,
            databaseService: serviceAssembly.databaseService,
            networkService: serviceAssembly.networkService,
            workout: workoutDTO),
                                         presentationAssemly: self)
    }
    
    func homeScreen() -> HomeViewController {
        HomeViewController(presenter: HomePresenter(networkService: serviceAssembly.networkService,
                                                    userInfoService: serviceAssembly.userInfoService,
                                                    databaseService: serviceAssembly.databaseService, notificationService: serviceAssembly.notificationService
                                                   ),
                           presentationAssembly: self)
    }
    
    func settingsScreen() -> SettingsViewController {
        return SettingsViewController(presenter: SettingsPresenter(
            userInfoService: serviceAssembly.userInfoService,
            networkService: serviceAssembly.networkService,
            databaseService: serviceAssembly.databaseService
        ),
                                      presentationAssembly: self
        )
    }
    
    func chooseGoalScreen(viewState: ChooseGoalViewState) -> ChooseGoalLevelViewController {
        return ChooseGoalLevelViewController(viewState: viewState,
                                             presenter: ChooseGoalPresenter(networkService: serviceAssembly.networkService,
                                                                            userInfoService: serviceAssembly.userInfoService,
                                                                            databaseService: serviceAssembly.databaseService),
                                             presentationAssembly: self)
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
            !serviceAssembly.userInfoService.userId.isEmpty
        else {
            return enterScreen()
        }
        
        return tabBarViewController()
    }
    
    func workoutDetailScreen(workout: WorkoutDTO,
                             delegate: WorkoutDetailDelegate?) -> ConfigureWorkoutViewController {
        return ConfigureWorkoutViewController(presenter: ConfigureWorkoutPresenter(workout: workout,
                                                                                   infoService: serviceAssembly.userInfoService,
                                                                                   databaseService: serviceAssembly.databaseService, notificationService: serviceAssembly.notificationService,
                                                                                   delegate: delegate
                                                                                  ))
    }
    
    func changeRootViewController(on viewController: UIViewController) {
        if #available(iOS 13.0, *) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController)
        } else {
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(viewController)
        }
    }
}
