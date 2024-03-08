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
        presenter.attachView(self)
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
        let model = presenter.userModel
        contentView.setupUserSkill(model.level, points: model.userPoints)
    }
    
    @objc
    func playButtonTapped() {
        guard let workout = presenter.currentActiveWorkout else { return }
        let vc = UINavigationController(rootViewController: presentationAssembly.playWorkoutScreen(workoutDTO: workout))
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc
    func headerNotificationButtonTapped() {
        presenter.notificationTapped()
    }

    @objc
    func headerSettingsButtonTapped() {
        presenter.homeHeaderSettingsTapped()
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

// MARK: - View
extension HomeViewController: IHomeView {
    
    func showMessage(text: String) {
        displayMsg(title: nil, msg: text)
    }
    
    func showActiveNotification(show: Bool) {
        contentView.showActiveNotification(show: show)
    }
    
    func updateDataSource(info: [HomeViewModel]) {
        datasource = info
        contentView.tableView.reloadData()
    }
    
    func updateStatus(userModel: UserModel) {
        contentView.setupUserSkill(userModel.level, points: userModel.userPoints)
    }
    
    func goToWorkoutDetail(workoutDTO: WorkoutDTO) {
        let wrktDetail = presentationAssembly.workoutDetailScreen(workout: workoutDTO,
                                                                  delegate: self)
        navigationController?.pushViewController(wrktDetail, animated: true)
    }
    
    func showLoader(toggle: Bool) {
        contentView.showLoader(toggle: toggle)
    }
    
    func showHeaderState(_ state: HomeHeaderState) {
        contentView.setupHeader(state: state)
    }
}

// MARK: - Delegates
extension HomeViewController: WorkoutTableViewCellDelegate, WorkoutDetailDelegate {
    func notificationWasChanged() {
        presenter.notificationForDetailWorkoutWasChanged()
    }
    
    func workoutLevelWasChanged() {
        presenter.skillWasChanged()
    }
    
    func editButtonTapped(id: Int) {
        presenter.workoutDetailTapped(id: id)
    }
}
