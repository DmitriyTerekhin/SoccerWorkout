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
    var trainingTime: String {
        return contentView.trainingTime
    }
    
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
        contentView.setupUserSkill(presenter.user.level, points: presenter.user.userPoints)
        contentView.tableView.dataSource = self
        datasource = presenter.getExcercise()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.startExercise()
        playButtonTapped()
    }
    
    @objc 
    func completeExcersiceTapped() {
        presenter.startExercise()
    }
    
    @objc
    func playButtonTapped() {
        presenter.isTimerPlay = !presenter.isTimerPlay
        contentView.playOrStopTimer(play: presenter.isTimerPlay)
    }

}

// MARK: - View
extension PlayWorkoutViewController: IPlayWorkoutView {
    
    func playVideo(url: URL?) {
        contentView.configureVideoPlayer(with: url)
    }
    
    func setupActiveDataSource(exersice: [ExerciseModel], numberOfActiveEx: String) {
        contentView.showActiveNumberExcercise(number: numberOfActiveEx)
        datasource = exersice
        contentView.tableView.reloadData()
    }
    
    func goToSessionFinishedScreen(info: [FinishedResultstTypes]) {
        contentView.playOrStopTimer(play: false)
        contentView.showFinishedView(info: info)
    }
    
    func goHomeScreen() {
        dismiss(animated: true)
    }
    
    func stopTimer() {
        contentView.playOrStopTimer(play: false)
    }
    
    func setupImage(imageURL: String) {
        contentView.setupImage(imageURL: imageURL)
    }
    
    func showSendingLoader(togle: Bool) {
        contentView.botttomView.completeButton.showLoader(toggle: togle)
    }
    func showError(message: String) {
        displayMsg(title: nil, msg: message)
        contentView.botttomView.completeButton.setTitle("Try again", for: .normal)
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
