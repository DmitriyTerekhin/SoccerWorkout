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
    private let dataSource: [SettingsTypes] = [.termsOfUse, .privacy, .rateUs, .delete]
    
    init(presenter: ISettingPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        contentView.addStatus(to: navigationController?.navigationBar)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
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
