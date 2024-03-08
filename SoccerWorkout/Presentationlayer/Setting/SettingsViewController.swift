//
//  SettingsViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let contentView = SettingsView()
    private let presenter: ISettingPresenter
    private let presentationAssembly: IPresentationAssembly
    private let dataSource: [SettingsTypes] = [.termsOfUse, .privacy, .rateUs, .delete]
    
    init(presenter: ISettingPresenter, presentationAssembly: IPresentationAssembly) {
        self.presenter = presenter
        self.presentationAssembly = presentationAssembly
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
        setupView()
    }
    
    private func setupView() {
        contentView.addStatus(to: navigationController?.navigationBar)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.goalView.configureView(level: nil)
    }
    
    @objc
    func beginnerTapped() {
        presenter.saveUserSkill(skill: .beginner)
    }
    
    @objc
    func championTapped() {
        presenter.saveUserSkill(skill: .champion)
    }
    
    @objc
    func expertTapped() {
        presenter.saveUserSkill(skill: .expert)
    }
    
    @objc
    func changeGoalLevelTapped() {
        let viewController = presentationAssembly.chooseGoalScreen(viewState: .edit(currentSkill: presenter.userModel.level))
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }

}

// MARK: - View
extension SettingsViewController: ISettingsView {
    func showWebView(url: String) {
        let webview = presentationAssembly.webViewController(site: url, title: nil)
        navigationController?.pushViewController(webview, animated: true)
    }
    
    func goToEnterScreen() {
        let enterView = presentationAssembly.enterScreen()
        presentationAssembly.changeRootViewController(on: UINavigationController(rootViewController: enterView))
    }
    
    func updateStatus(userModel: UserModel) {
        contentView.setupUserSkill(userModel.level, points: userModel.userPoints)
    }
}

// MARK: - UITableView datasource
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID) as! SettingsTableViewCell
        cell.configureView(type: dataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.settingDidSelect(dataSource[indexPath.row])
    }
}
