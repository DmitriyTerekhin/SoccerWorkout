//
//  ConfigureWorkoutViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class ConfigureWorkoutViewController: UIViewController {
    
    private let presenter: IConfigureWorkoutPresenter
    private var datasource: [ExerciseModel] = []
    private let contentView = ConfigureWorkoutView()
    
    init(presenter: IConfigureWorkoutPresenter) {
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
        datasource = presenter.excerciseDataSource
        contentView.tableView.dataSource = self
        contentView.configureHeaderView.setCurrentActiveSkill(activeSkill: .beginner)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(dismmiss), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc
    func dismmiss() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table methods
extension ConfigureWorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutExerciseTableViewCell.reuseID) as! WorkoutExerciseTableViewCell
        cell.configureView(model: datasource[indexPath.row])
        cell.selectionStyle = .none
        cell.separatorView.isHidden = (datasource.count - 1) == indexPath.row
        return cell
    }
}
