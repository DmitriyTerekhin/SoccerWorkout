//

import Foundation

protocol IChooseGoalPresenter: AnyObject {
    func continueTapped()
    func saveGoalLevel(goal: Skill)
    func saveGoalTime(month: GoalTime)
    func attachView(_ view: IChooseGoalView)
}

protocol IChooseGoalView: AnyObject {
    func updateContinueButtonState(isDissabled: Bool)
    func goToTabBar()
}

class ChooseGoalPresenter: IChooseGoalPresenter {
    
    weak var view: IChooseGoalView?
    private var choosenGoalLevel: Skill?
    private var chooserGoalTime: GoalTime?
    
    func attachView(_ view: IChooseGoalView) {
        self.view = view
        checkContinueButtonState()
    }
    
    func continueTapped() {
        view?.goToTabBar()
    }
    
    func saveGoalLevel(goal: Skill) {
        choosenGoalLevel = goal
        checkContinueButtonState()
    }
    
    func saveGoalTime(month: GoalTime) {
        chooserGoalTime = month
        checkContinueButtonState()
    }
    
    private func checkContinueButtonState() {
        guard choosenGoalLevel != nil && chooserGoalTime != nil else {
            view?.updateContinueButtonState(isDissabled: true)
            return
        }
        view?.updateContinueButtonState(isDissabled: false)
    }
}
