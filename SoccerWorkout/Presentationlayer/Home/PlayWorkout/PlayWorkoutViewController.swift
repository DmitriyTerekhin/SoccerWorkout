//
//  PlayWorkoutViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import UIKit

class PlayWorkoutViewController: UIViewController {
    
    private let contentView = PlayWorkoutView()
    private let presenter: IPlayWorkoutPresenter
    private let presentationAssemly: IPresentationAssembly
    private var datasource: [ExerciseModel] = []
    
    init(presenter: IPlayWorkoutPresenter, presentationAssemly: IPresentationAssembly) {
        self.presenter = presenter
        self.presentationAssemly = presentationAssemly
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
        contentView.addStatus(to: navigationController?.navigationBar)
        contentView.tableView.dataSource = self
        datasource = presenter.getExcercise()
    }
    
    @objc 
    func completeExcersiceTapped() {
        presenter.completeExercise()
    }
    
    @objc
    func playButtonTapped() {
        dismiss(animated: true)
    }

}

// MARK: - View
extension PlayWorkoutViewController: IPlayWorkoutView {
    func setupActiveDataSource(exersice: [ExerciseModel]) {
        self.datasource = exersice
        contentView.tableView.reloadData()
    }
    
    func goToSessionFinishedScreen(info: [FinishedResultstTypes]) {
        contentView.showFinishedView(info: info)
    }
    
    func goHomeScreen() {
        dismiss(animated: true)
    }
}

// MARK: - Table methods
extension PlayWorkoutViewController: UITableViewDataSource {
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
