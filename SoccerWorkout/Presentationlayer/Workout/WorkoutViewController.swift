//
//  WorkoutViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    private let contentView = WorkoutView()
    private let presenter: IWorkoutPresenter
    private var dataSource: [WorkoutHistorySectionViewModel] = []
    var viewState: WorkoutState = .history
    
    init(presenter: IWorkoutPresenter) {
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
        setupView()
    }
    
    private func setupView() {
        contentView.addStatus(to: navigationController?.navigationBar)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.reloadData()
        presenter.historyButtonTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.configureView(for: viewState)
        contentView.updateUserStatus(presenter.userModel.level, points: presenter.userModel.userPoints)
    }
    
    @objc 
    func allButtonTapped() {
        viewState = .all
        contentView.configureView(for: viewState)
        presenter.allButtonTapped()
    }
    
    @objc
    func historyButtonTapped() {
        viewState = .history
        contentView.configureView(for: viewState)
        presenter.historyButtonTapped()
    }

}

// MARK: - View
extension WorkoutViewController: IWorkoutView {
    func showMessage(text: String) {
        displayMsg(title: nil, msg: text)
    }
    
    func updateStatus() {
        let model = presenter.userModel
        contentView.updateUserStatus(model.level, points: model.userPoints)
    }
    
    func showHistory(history: [WorkoutHistorySectionViewModel]) {
        dataSource = history
        contentView.emptyMessage.isHidden = !history.isEmpty
        contentView.tableView.reloadData()
    }
    
    func showAll(workouts: [WorkoutViewModel]) {
//        dataSource = workouts
//        contentView.emptyMessage.isHidden = true
//        contentView.tableView.reloadData()
    }
    
    func emptyTableAndStartLoader() {
        contentView.showLoader(toggle: true)
        dataSource = []
        contentView.tableView.reloadData()
    }
    
    func showLoader(toggle: Bool) {
        contentView.showLoader(toggle: toggle)
    }
    
    func showResultView(info: [FinishedResultstTypes]) {
        let resultVC = WorkoutResultViewController(workoutResultModels: info)
        resultVC.modalPresentationStyle = .overFullScreen
        present(resultVC, animated: true)
    }
}

// MARK: - dataSource
extension WorkoutViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WorkoutSectionHeaderView.reuseID) as! WorkoutSectionHeaderView
        headerView.setHeader(date: dataSource[section].date)
        headerView.backgroundColor = UIColor.AppCollors.background
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseID) as! HistoryTableViewCell
        cell.configureView(model: dataSource[indexPath.section].workouts[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.historyWassTapped(id: dataSource[indexPath.section].workouts[indexPath.row].id)
    }
}
