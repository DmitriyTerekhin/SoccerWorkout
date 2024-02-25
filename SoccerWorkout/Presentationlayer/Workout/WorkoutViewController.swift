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
    private var dataSource: [WorkoutViewModel] = []
    private var viewState: WorkoutState = .all
    
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
        dataSource = presenter.getTrainings()
        contentView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.configureView(for: viewState)
    }
    
    @objc 
    func allButtonTapped() {
        viewState = .all
        contentView.configureView(for: viewState)
    }
    
    @objc
    func historyButtonTapped() {
        viewState = .history
        contentView.configureView(for: viewState)
    }

}

// MARK: - View
extension WorkoutViewController: IWorkoutView {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.reuseID) as! WorkoutTableViewCell
        cell.configureView(model: dataSource[indexPath.section].workouts[indexPath.row])
        return cell
    }
}
