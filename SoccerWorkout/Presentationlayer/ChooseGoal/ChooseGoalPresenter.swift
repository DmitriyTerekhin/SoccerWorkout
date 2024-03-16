//

import Foundation

protocol IChooseGoalPresenter: AnyObject {
    func continueTapped(authDTO: AuthDTO) 
    func saveGoalLevel(goal: Skill)
    func saveGoalTime(month: GoalTime)
    func attachView(_ view: IChooseGoalView)
    func updateUserModel()
}

protocol IChooseGoalView: AnyObject {
    func showError(message: String)
    func showLoaderOnButton(isLoading: Bool)
    func updateContinueButtonState(isDissabled: Bool)
    func goToTabBar()
}

class ChooseGoalPresenter: IChooseGoalPresenter {
    
    weak var view: IChooseGoalView?
    private var choosenGoalLevel: Skill?
    private var chooserGoalTime: GoalTime?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    private let userInfoService: ISensentiveInfoService
    
    init(
        networkService: INetworkService,
        userInfoService: ISensentiveInfoService,
        databaseService: IDatabaseService
    ) {
        self.userInfoService = userInfoService
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func attachView(_ view: IChooseGoalView) {
        self.view = view
        checkContinueButtonState()
    }
    
    func saveGoalLevel(goal: Skill) {
        choosenGoalLevel = goal
        checkContinueButtonState()
    }
    
    func saveGoalTime(month: GoalTime) {
        chooserGoalTime = month
        checkContinueButtonState()
    }
    
    func updateUserModel() {
        var userModel = databaseService.getUserModel()
        userModel.goalTime = chooserGoalTime
        userModel.goalLevel = choosenGoalLevel
        databaseService.saveUserModel(model: userModel, completionHandler: {_ in})
    }
    
    private func checkContinueButtonState() {
        guard choosenGoalLevel != nil && chooserGoalTime != nil else {
            view?.updateContinueButtonState(isDissabled: true)
            return
        }
        view?.updateContinueButtonState(isDissabled: false)
    }
    
    func continueTapped(authDTO: AuthDTO) {
        view?.showLoaderOnButton(isLoading: true)
        authDTO.goal = choosenGoalLevel?.level
        networkService.createUser(authDTO: authDTO) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let authDTO):
                    strongSelf.userInfoService.changeUserInAppValue(isUserInApp: true)
                    strongSelf.userInfoService.saveUserId(id: authDTO.userId)
                    strongSelf.userInfoService.saveUserSkill(skill: Skill(level: authDTO.level)!)
                    strongSelf.view?.showLoaderOnButton(isLoading: true)
                    strongSelf.databaseService.saveUserModel(model:
                                                                UserModel(
                                                                    level: Skill(level: authDTO.level)!,
                                                                    userId: authDTO.userId,
                                                                    userPoints: 0,
                                                                    goalLevel: strongSelf.choosenGoalLevel,
                                                                    goalTime: strongSelf.chooserGoalTime
                                                                )
                    ) { _ in
                        strongSelf.view?.goToTabBar()
                    }
                case .failure(let failure):
                    strongSelf.view?.showError(message: failure.textToDisplay)
                }
            }
        }
    }

}
