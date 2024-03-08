//
//  HomePresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

protocol IHomePresenter: AnyObject {
    var currentActiveWorkout: WorkoutDTO? { get }
    var userModel: UserModel { get }
    func attachView(_ view: IHomeView)
    func notificationTapped()
    func homeHeaderSettingsTapped()
    func workoutDetailTapped(id: Int)
    func skillWasChanged()
    func notificationForDetailWorkoutWasChanged()
}

protocol IHomeView: AnyObject {
    func updateDataSource(info: [HomeViewModel])
    func updateStatus(userModel: UserModel)
    func showActiveNotification(show: Bool)
    func showMessage(text: String)
    func goToWorkoutDetail(workoutDTO: WorkoutDTO)
    func showLoader(toggle: Bool)
    func showHeaderState(_ state: HomeHeaderState)
}

class HomePresenter: IHomePresenter {
    
    private let networkService: INetworkService
    private let userInfoService: ISensentiveInfoService
    private var notificationIsActive: Bool = false
    private let databaseService: IDatabaseService
    private let notificationService: INotificationService
    private var workoutDetailChanging: WorkoutDTO?
    private unowned var view: IHomeView!
    
    
    var userModel: UserModel
    var currentActiveWorkout: WorkoutDTO?
    
    private var workoutsList: [WorkoutDTO] = []
    private var training: [HomeViewModel] = []
    
    init(
        networkService: INetworkService,
        userInfoService: ISensentiveInfoService,
        databaseService: IDatabaseService,
        notificationService: INotificationService
    ) {
        self.userModel = databaseService.getUserModel()
        self.databaseService = databaseService
        self.networkService = networkService
        self.userInfoService = userInfoService
        self.notificationService = notificationService
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.methodOfReceivedNotification(notification:)),
                                               name: Notification.Name(NotificationsConstants.userStatusNeedToUpdate), object: nil)
    }
    
    func attachView(_ view: IHomeView) {
        self.view = view
        loadHomeList()
    }
    
    func homeHeaderSettingsTapped() {
        guard let wrkt = currentActiveWorkout else { return }
        view.goToWorkoutDetail(workoutDTO: wrkt)
    }
    
    func loadHomeList() {
        view.showLoader(toggle: true)
        networkService.loadAvailableWorkouts(userId: userInfoService.userId) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.view.showLoader(toggle: false)
                switch result {
                case .success(let workouts):
                    strongSelf.prepreCurrentActive(workouts: workouts)
                    if let workouts = strongSelf.currentActiveWorkout,
                       let date = workouts.timeStart {
                        strongSelf.preapreNotification(wrktName: workouts.type,
                                                       timeStart: date)
                        strongSelf.view?.showHeaderState(.currentActive(name: workouts.type, date: date))
                    } else {
                        strongSelf.view?.showHeaderState(.allDone)
                    }
                    strongSelf.workoutsList = workouts
                    strongSelf.training = strongSelf.getTrainings(from: workouts)
                    strongSelf.view.updateDataSource(info: strongSelf.training)
                case .failure(let failure):
                    strongSelf.view.showMessage(text: failure.textToDisplay)
                }
            }
        }
    }
    
    func prepreCurrentActive(workouts: [WorkoutDTO]) {
        currentActiveWorkout = workouts.first(where: {
            if let date = $0.date.toDate(withFormat: .YYYYMMDDTHHMMSS) {
                if date > Date() && Calendar.current.isDateInToday(date) {
                    return true
                } else {
                    return false
                }
            }
            return false
        })
        guard let currentWRKT = currentActiveWorkout else { return }
        notificationForDetailWorkoutWasChanged()
        currentWRKT.choosenUserLevel = databaseService.getWorkout(id: currentWRKT.id)?.chooseLevel ?? userModel.level
    }
    
    func workoutDetailTapped(id: Int) {
        guard let wrk = workoutsList.first(where: {$0.id == id}) else { return }
        workoutDetailChanging = wrk
        view.goToWorkoutDetail(workoutDTO: wrk)
    }
    
    func notificationTapped() {
        guard
            let wrkt = currentActiveWorkout,
            let time = currentActiveWorkout?.timeStart
        else { return }
        notificationIsActive = !notificationIsActive
        if notificationIsActive {
            notificationService.setReminder(trainingName: wrkt.type, date: time, completionHandler: {_ in})
        } else {
            notificationService.removeCurrentReminder(trainingName: wrkt.type, date: time)
        }
        view.showActiveNotification(show: notificationIsActive)
    }
    
    private func preapreNotification(wrktName: String, timeStart: Date) {
        notificationIsActive = notificationService.isNotificationExist(trainingName: wrktName, date: timeStart)
        view.showActiveNotification(show: notificationIsActive)
    }
    
    func notificationForDetailWorkoutWasChanged() {
        guard let wrkt = currentActiveWorkout, let date = wrkt.timeStart else { return }
        preapreNotification(wrktName: wrkt.type, timeStart: date)
    }
    
    func skillWasChanged() {
        guard 
            let workout = workoutDetailChanging,
            let newSkill = workout.choosenUserLevel
        else { return }
    
        let title = "\(WorkoutType(rawValue: workout.type).title) /"
        let titleAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.white
        ] as [NSAttributedString.Key : Any]
        
        let skillAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.orange
        ] as [NSAttributedString.Key : Any]
        
        let titleAttributedStringComponents = [
            NSAttributedString(string: title,
                                     attributes: titleAttributes),
            NSAttributedString(string: newSkill.rawValue.capitalized,
                                     attributes: skillAttributes)
        ] as [AttributedStringComponent]
        training.first(where: { $0.id == workout.id })?.title = NSAttributedString(from: titleAttributedStringComponents, defaultAttributes: [:])!
        view.updateDataSource(info: training)
        workoutDetailChanging = nil
    }
    
    func getTrainings(from workoutsDTO: [WorkoutDTO]) -> [HomeViewModel] {
        return workoutsDTO.compactMap { model in
            guard
                model != currentActiveWorkout,
                let date = model.date.toDate(withFormat: .YYYYMMDDTHHMMSS),
                date > Date()
            else { return nil }
            let title = "\(WorkoutType(rawValue: model.type).title) /"
            let titleAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.white
            ] as [NSAttributedString.Key : Any]
            
            let skillAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.orange
            ] as [NSAttributedString.Key : Any]
            
            
            let skill = databaseService.getWorkout(id: model.id)?.chooseLevel ?? userModel.level
            model.choosenUserLevel = skill
            let titleAttributedStringComponents = [
                NSAttributedString(string: title,
                                         attributes: titleAttributes),
                NSAttributedString(string: skill.rawValue.capitalized,
                                         attributes: skillAttributes)
            ] as [AttributedStringComponent]
            
            // Subtitle
            let dateString = model.timeStart?.getTrainingDateString() ?? "Underfind"
            let dateAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.defaultGray
            ] as [NSAttributedString.Key : Any]
            
            return HomeViewModel(
                id: model.id,
                date: model.timeStart,
                title: NSAttributedString(from: titleAttributedStringComponents, defaultAttributes: [:])!,
                subtitle: NSAttributedString(string: dateString, attributes: dateAttributes)
            )
        }
    }
    
    @objc 
    func methodOfReceivedNotification(notification: Notification) {
        userModel = databaseService.getUserModel()
        view.updateStatus(userModel: userModel)
        loadHomeList()
    }
}

extension Date {
    func getTrainingDateString(format: String? = nil) -> String {
        let format = format ?? "dd MMM YYYY / HH:mm a"
        let calendar = Calendar.current
        if calendar.isDateInYesterday(self) { return "Yesterday, \(self.toString(format))" }
        else if calendar.isDateInToday(self) { return "Today, \(self.toString(format))" }
        else if calendar.isDateInTomorrow(self) { return "Tomorrow, \(self.toString(format))" }
        else {
            return self.toString("EEEE, dd MMM YYYY / HH:mm a")
        }
    }
}
