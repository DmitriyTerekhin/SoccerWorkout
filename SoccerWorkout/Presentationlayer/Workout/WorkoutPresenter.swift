//
//  WorkoutPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

protocol IWorkoutPresenter: AnyObject {
    var userModel: UserModel { get }
    func attachView(_ view: IWorkoutView)
    func historyButtonTapped()
    func allButtonTapped()
    func historyWassTapped(id: Int)
}

protocol IWorkoutView: AnyObject {
    var viewState: WorkoutState { get }
    func updateStatus()
    func showMessage(text: String)
    func showAll(workouts: [WorkoutViewModel])
    func showHistory(history: [WorkoutHistorySectionViewModel])
    func showLoader(toggle: Bool)
    func emptyTableAndStartLoader()
    func showResultView(info: [FinishedResultstTypes])
}

class WorkoutPresenter: IWorkoutPresenter {
    
    private let networkService: INetworkService
    private let userInfoService: ISensentiveInfoService
    private var history: [WorkoutDTO] = []
    private var allWorkouts: [WorkoutDTO] = []
    private var databaseService: IDatabaseService
    
    weak var view: IWorkoutView?
    var userModel: UserModel
    
    init(
        networkService: INetworkService,
        userInfoService: ISensentiveInfoService,
        databaseService: IDatabaseService
    ) {
        self.userModel = databaseService.getUserModel()
        self.databaseService = databaseService
        self.networkService = networkService
        self.userInfoService = userInfoService
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.methodOfReceivedNotification(notification:)),
                                               name: Notification.Name(NotificationsConstants.userStatusNeedToUpdate), object: nil)
    }
    
    func attachView(_ view: IWorkoutView) {
        self.view = view
    }
    
    func historyButtonTapped() {
        loadHistory()
    }
    
    func allButtonTapped() {
        loadHomeList()
    }
    
    func loadHistory() {
        view?.emptyTableAndStartLoader()
        networkService.loadHistory(userId: userModel.userId) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.view?.showLoader(toggle: false)
                switch result {
                case .success(let workouts):
                    strongSelf.history = workouts
                    strongSelf.view?.showHistory(history: strongSelf.getTrainings(workouts: workouts))
                case .failure(let failure):
                    strongSelf.view?.showMessage(text: failure.textToDisplay)
                }
            }
        }
    }
    
//    private func getWorkoutHistoryViewModel() -> [WorkoutHistoryViewModel] {
//        
//        let title = "\(WorkoutType(rawValue: "Leg workout").title) /"
//        let titleAttributes = [
//            .font: UIFont(font: .PoppinsMedium, size: 14),
//            .foregroundColor: UIColor.white
//        ] as [NSAttributedString.Key : Any]
//        
//        let skillAttributes = [
//            .font: UIFont(font: .PoppinsMedium, size: 14),
//            .foregroundColor: UIColor.AppCollors.orange
//        ] as [NSAttributedString.Key : Any]
//        
//        
////        let skill = databaseService.getWorkout(id: model.id)?.chooseLevel ?? userModel.level
////        model.choosenUserLevel = skill
//        let titleAttributedStringComponents = [
//            NSAttributedString(string: title,
//                                     attributes: titleAttributes),
//            NSAttributedString(string: Skill(level: 2)!.rawValue.capitalized,
//                                     attributes: skillAttributes)
//        ] as [AttributedStringComponent]
//        
//        // Subtitle
////        let date = model.date.toDate(withFormat: String.DateFormats.YYYYMMDDHHMMSS) ?? Date()
////        let dateString = date.toString("EEEE, dd MMM YYYY / HH:mm a")
//        let dateAttributes = [
//            .font: UIFont(font: .PoppinsMedium, size: 14),
//            .foregroundColor: UIColor.AppCollors.defaultGray
//        ] as [NSAttributedString.Key : Any]
//        
//        let model = WorkoutHistoryViewModel(id: <#Int#>,
//                                            title: NSAttributedString(from: titleAttributedStringComponents, defaultAttributes: [:])!,
//                                            subtitle: NSAttributedString(string: "Tomorrow, 11 Fed 2023 / 19:00 am", attributes: dateAttributes),
//                                            points: 3,
//                                            totalNumberOfEx: "22",
//                                            totalTrainingTime: "60:00")
//        
//        return [
//            model
//        ]
//    }
    
    func loadHomeList() {
//        view?.emptyTableAndStartLoader()
//        networkService.loadWorkoutList(userId: userInfoService.userId) { [weak self] result in
//            guard let strongSelf = self else { return }
//            DispatchQueue.main.async {
//                strongSelf.view?.showLoader(toggle: false)
//                switch result {
//                case .success(let workouts):
//                    strongSelf.allWorkouts = workouts
//                    strongSelf.view?.showAll(workouts: strongSelf.getTrainings(workouts: workouts))
//                case .failure(let failure):
//                    strongSelf.view?.showMessage(text: failure.textToDisplay)
//                }
//            }
//        }
    }
    
    func getTrainings(workouts: [WorkoutDTO]) -> [WorkoutHistorySectionViewModel] {
        var workoutModels: [WorkoutHistorySectionViewModel] = []
        
        workouts.forEach { model in
            let title = "\(model.type) /"
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
                NSAttributedString(string: self.userModel.level.rawValue.capitalized,
                                         attributes: skillAttributes)
            ] as [AttributedStringComponent]
            
            // Subtitle
            let date = model.date.toDate(withFormat: .YYYYMMDDTHHMMSS) ?? Date()
            let dateString = date.toString("EEEE, dd MMM YYYY / HH:mm a")
            let dateAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.defaultGray
            ] as [NSAttributedString.Key : Any]
            let databaseHistoryModel = databaseService.getWorkoutHistory(id: model.id)
            let wasPassed = databaseHistoryModel != nil
            let points = wasPassed ? "+\(databaseHistoryModel?.earnedPoints ?? String(userModel.level.points))" : "Missed"
            let historyModel = WorkoutHistoryViewModel(id: model.id,
                                                       title: NSAttributedString(from: titleAttributedStringComponents,
                                                                                 defaultAttributes: [:])!,
                                                       subtitle: NSAttributedString(string: dateString, attributes: dateAttributes),
                                                       points: points,
                                                       totalNumberOfEx: databaseHistoryModel?.totalNumberOfEx ?? "-",
                                                       totalTrainingTime: databaseHistoryModel?.trainingTime ?? "-",
                                                       date: model.timeStart,
                                                       wasPassed: wasPassed
            )
            
            if let lastWorkout = workoutModels.last,
               let lastWorkoutInDay = lastWorkout.workouts.last,
               let lastWRKTDate = lastWorkoutInDay.date,
               Calendar.current.isDate(lastWRKTDate, equalTo: lastWorkout.date,
                                       toGranularity: .day) {
                lastWorkout.workouts.append(historyModel)
            } else {
                workoutModels.insert(
                    WorkoutHistorySectionViewModel(date: date,
                                                   workouts: [
                                                    historyModel
                                                   ])
                                     , at: 0)
            }
        }
        return workoutModels
    }
    
    func historyWassTapped(id: Int) {
        guard let history = databaseService.getWorkoutHistory(id: id) else { return }
        let defaultAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.white
        ] as [NSAttributedString.Key : Any]
        let lowAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.orange
        ] as [NSAttributedString.Key : Any]

        let attributedStringComponents = [
            NSAttributedString(string: "\(history.type) / ",
                                     attributes: defaultAttributes),
            NSAttributedString(string: history.chooseLevel.rawValue.capitalized,
                                     attributes: lowAttributes)
        ] as [AttributedStringComponent]
        let trainingNameAttr = NSAttributedString(from: attributedStringComponents,
                           defaultAttributes: defaultAttributes)!
        let result: [FinishedResultstTypes] = [
            .excerciseName(title: trainingNameAttr),
            .totalNumber(title: NSAttributedString(string: "Total number of exercises",
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ]),
                         value: NSAttributedString(string: history.totalNumberOfEx,
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ])),
            .totalTrainingTime(title: NSAttributedString(string: "Total training time",
                                                         attributes: [
                                                          NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                          NSAttributedString.Key.foregroundColor : UIColor.white,
                                                         ]),
                               value: NSAttributedString(string: history.trainingTime,
                                                         attributes: [
                                                          NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                          NSAttributedString.Key.foregroundColor : UIColor.white,
                                                         ])),
            .pointEarned(title: NSAttributedString(string: "Points earned",
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ]),
                         value: NSAttributedString(string: "+" + history.earnedPoints,
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.AppCollors.orange,
                                                   ]))
        ]
        view?.showResultView(info: result)
    }
    
    @objc
    func methodOfReceivedNotification(notification: Notification) {
        userModel = databaseService.getUserModel()
        loadHistory()
        view?.updateStatus()
    }

}
