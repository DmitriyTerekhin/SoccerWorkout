//
//  ChooseSkillViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

class ChooseSkillViewController: UIViewController {
    
    private let contentView = ChooseSkillView()
    private let presenter: ISkillRegistrationPresenter
    private let presentationAssembly: IPresentationAssembly
    
    init(presentationAssembly: IPresentationAssembly, presenter: ISkillRegistrationPresenter) {
        self.presentationAssembly = presentationAssembly
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        presenter.attachView(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func beginnerTapped() {
        contentView.skillTapped(skill: .beginner, points: 0)
        presenter.skillChoosed(skill: .beginner)
    }
    
    @objc
    func championTapped() {
        contentView.skillTapped(skill: .champion, points: 0)
        presenter.skillChoosed(skill: .champion)
    }
    
    @objc
    func expertTapped() {
        contentView.skillTapped(skill: .expert, points: 0)
        presenter.skillChoosed(skill: .expert)
    }
    
    @objc
    func continueTapped() {
        presenter.continueTapped()
    }
}

// MARK: - View
extension ChooseSkillViewController: ISkillRegistrationView {
    func makeContinueButtonActive() {
        contentView.continueButton.changeGradientButtonState(isActive: true)
    }
    
    func showLoaderOnButton(isLoading: Bool) {
        contentView.continueButton.showLoader(toggle: isLoading)
    }
    
    func showError(message: String) {
        displayMsg(title: nil, msg: message)
    }
    
    func goToChooseGoalScreen(authDTO: AuthDTO) {
        navigationController?.pushViewController(
            presentationAssembly.chooseGoalScreen(viewState: .setup(authDTO: authDTO)),
            animated: true
        )
    }
}
