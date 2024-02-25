//
//  HomeViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let presenter: IHomePresenter
    private let presentationAssembly: IPresentationAssembly
    private var datasource: [HomeViewModel] = []
    private let contentView: HomeView = HomeView()
    
    init(presenter: IHomePresenter, presentationAssembly: IPresentationAssembly) {
        self.presenter = presenter
        self.presentationAssembly = presentationAssembly
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
        navigationController?.navigationBar.tintColor = .AppCollors.background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        contentView.addStatus(to: navigationController?.navigationBar)
        contentView.tableView.dataSource = self
        datasource = presenter.getTrainings()
        contentView.tableView.reloadData()
    }
    
    @objc
    func playButtonTapped() {
        let vc = UINavigationController(rootViewController: presentationAssembly.playWorkoutScreen())
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

}

// MARK: - Table methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.reuseID) as! WorkoutTableViewCell
        cell.delegate = self
        cell.configureView(model: datasource[indexPath.row])
        return cell
    }
}

// MARK: - Delegates
extension HomeViewController: WorkoutTableViewCellDelegate {
    func editButtonTapped() {
        navigationController?.pushViewController(presentationAssembly.workoutDetailScreen(), animated: true)
    }
}
