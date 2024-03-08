//
//  ConfigureWorkoutViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

protocol WorkoutDetailDelegate: AnyObject {
    func workoutLevelWasChanged()
    func notificationWasChanged()
}

class ConfigureWorkoutViewController: UIViewController, AskChangesDelegate {
    
    private let presenter: IConfigureWorkoutPresenter
    private var datasource: [ExerciseModel] = []
    private let contentView = ConfigureWorkoutView()
    private var askVC = AskChangesViewController()
        
    init(presenter: IConfigureWorkoutPresenter) {
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
        contentView.tableView.dataSource = self
        askVC.delegate = self
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.sizeToFit()
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc
    func headerNotificationButtonTapped() {
        presenter.notificationTapped()
    }
    
    @objc
    func backButtonTapped() {
        presenter.backButtonTapped()
    }
    
    @objc
    func beginnerTapped() {
        contentView.skillTapped(skill: .beginner)
        presenter.skillTapped(skill: .beginner)
    }
    
    @objc
    func championTapped() {
        contentView.skillTapped(skill: .champion)
        presenter.skillTapped(skill: .champion)
    }
    
    @objc
    func expertTapped() {
        contentView.skillTapped(skill: .expert)
        presenter.skillTapped(skill: .expert)
    }
    func saveTapped() {
        presenter.saveLevelForCurrentWorkout()
    }
    
    func noTapped() {
        goBack()
    }
}

// MARK: - View
extension ConfigureWorkoutViewController: IConfigureWorkoutView {
    func showActiveNotification(show: Bool) {
        contentView.showActiveNotification(show: show)
    }
    
    func configureHeader(title: String, subtitle: String, for skill: Skill) {
        contentView.configureHeaderView.configureView(title: title, subtitle: subtitle)
        contentView.configureHeaderView.setCurrentActiveSkill(activeSkill: skill)
    }
    
    func updateExcercise(excercise: [ExerciseModel]) {
        datasource = excercise
        contentView.tableView.reloadData()
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func askToSaveChanges() {
        askVC.modalPresentationStyle = .overCurrentContext
        present(askVC, animated: false)
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
