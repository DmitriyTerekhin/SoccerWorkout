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
    func showLoaderOnButton(isLoading: Bool)
    func goToChooseGoalScreen(authDTO: AuthDTO)
    func makeContinueButtonActive()
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
        view.goToChooseGoalScreen(authDTO:
                                    AuthDTO(
                                        level: skill.level,
                                        userId: userId,
                                        token: Messaging.messaging().fcmToken
                                    )
        )
    }
}
