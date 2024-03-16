//

import UIKit

class ChooseGoalLevelViewController: UIViewController {
    
    private let contentView = ChooseGoalView()
    private let presenter: IChooseGoalPresenter
    private let presentationAssembly: IPresentationAssembly
    private let viewState: ChooseGoalViewState
    
    override func loadView() {
        view = contentView
        presenter.attachView(self)
    }
    
    init(viewState: ChooseGoalViewState, presenter: IChooseGoalPresenter, presentationAssembly: IPresentationAssembly) {
        self.viewState = viewState
        self.presenter = presenter
        self.presentationAssembly = presentationAssembly
        super.init(nibName: nil, bundle: nil)
        contentView.configureView(viewState: viewState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if case .edit(let level, let goal, let time) = viewState,
           let goalUn = goal,
           let timeUn = time {
            presenter.saveGoalLevel(goal: goalUn)
            presenter.saveGoalTime(month: timeUn)
        }
    }
    
    @objc
    func firstSkillButtonTapped() {
        contentView.skillTapped(skill: .champion)
        presenter.saveGoalLevel(goal: .champion)
    }
    
    @objc
    func secondSkillButtonTapped() {
        contentView.skillTapped(skill: .expert)
        presenter.saveGoalLevel(goal: .expert)
    }
    
    @objc
    func thirdSkillButtonTapped() {
        contentView.skillTapped(skill: .expertPlus)
        presenter.saveGoalLevel(goal: .expertPlus)
    }
    
    @objc
    func firstTimeGoalButtonTapped() {
        contentView.timeTapped(time: .twoMonth)
        presenter.saveGoalTime(month: .twoMonth)
    }
    
    @objc
    func secondTimeGoalButtonTapped() {
        contentView.timeTapped(time: .fourMonth)
        presenter.saveGoalTime(month: .fourMonth)
    }
    
    @objc
    func thirdTimeGoalButtonTapped() {
        contentView.timeTapped(time: .sixMonth)
        presenter.saveGoalTime(month: .sixMonth)
    }
    
    @objc
    func dontWantTapped() {
        if case .setup(let authDTO) = viewState {
            presenter.continueTapped(authDTO: authDTO)
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc
    func continueTapped() {
        if case .setup(let authDTO) = viewState {
            presenter.continueTapped(authDTO: authDTO)
        } else {
            presenter.updateUserModel()
            dismiss(animated: true)
        }
    }
    
}

// MARK: - View
extension ChooseGoalLevelViewController: IChooseGoalView {
    
    func showLoaderOnButton(isLoading: Bool) {
        contentView.continueButton.showLoader(toggle: isLoading)
    }
    
    func showError(message: String) {
        displayMsg(title: nil, msg: message)
    }
  
    func updateContinueButtonState(isDissabled: Bool) {
        contentView.continueButton.changeGradientButtonState(isActive: !isDissabled)
    }
    
    func goToTabBar() {
        presentationAssembly.changeRootViewController(on: presentationAssembly.tabBarViewController())
    }
}
