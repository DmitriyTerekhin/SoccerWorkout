//

import Foundation
import FirebaseMessaging

protocol ISkillRegistrationPresenter: AnyObject {
    func attachView(_ view: ISkillRegistrationView)
    func skillChoosed(skill: Skill)
    func continueTapped()
}

protocol ISkillRegistrationView: AnyObject {
    func showError(message: String)
    func goToChooseGoalScreen(level: Skill)
    func makeContinueButtonActive()
    func showLoaderOnButton(isLoading: Bool)
}

class SkillRegistrationPresenter: ISkillRegistrationPresenter {
    private let userId: String
    private var skill: Skill?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    private let userInfoService: ISensentiveInfoService
    private unowned var view: ISkillRegistrationView!
    
    init(
        userId: String,
        networkService: INetworkService,
        userInfoService: ISensentiveInfoService,
        databaseService: IDatabaseService
    ) {
        self.userId = userId
        self.userInfoService = userInfoService
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func attachView(_ view: ISkillRegistrationView) {
        self.view = view
    }
    
    func skillChoosed(skill: Skill) {
        view.makeContinueButtonActive()
        self.skill = skill
    }
    
    func continueTapped() {
        guard let skill = skill else { return }
        view.showLoaderOnButton(isLoading: true)
        networkService.createUser(userId: userId,
                                  level: skill.level,
                                  pushToken: Messaging.messaging().fcmToken) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let authDTO):
                    strongSelf.userInfoService.changeUserInAppValue(isUserInApp: true)
                    strongSelf.userInfoService.saveUserId(id: authDTO.userId)
                    strongSelf.userInfoService.saveUserSkill(skill: Skill(level: authDTO.level)!)
                    strongSelf.view.showLoaderOnButton(isLoading: true)
                    strongSelf.databaseService.saveUserModel(model: UserModel(level: Skill(level: authDTO.level)!,
                                                                              userId: authDTO.userId,
                                                                              userPoints: 0)) { _ in
                        strongSelf.view.goToChooseGoalScreen(level: skill)
                    }
                case .failure(let failure):
                    strongSelf.view.showError(message: failure.textToDisplay)
                }
            }
        }
    }
}
