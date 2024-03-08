//
//  PlayWorkoutPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import Foundation
import UIKit

protocol IPlayWorkoutPresenter: AnyObject {
    var user: UserModel { get }
    var isTimerPlay: Bool { get set }
    func attachView(_ view: IPlayWorkoutView)
    func getExcercise() -> [ExerciseModel]
    func startExercise()
}

protocol IPlayWorkoutView: AnyObject {
    var trainingTime: String { get }
    func setupActiveDataSource(exersice: [ExerciseModel], numberOfActiveEx: String)
    func goToSessionFinishedScreen(info: [FinishedResultstTypes])
    func goHomeScreen()
    func playButtonTapped()
    func setupImage(imageURL: String)
    func showSendingLoader(togle: Bool)
    func showError(message: String)
    func stopTimer()
    func playVideo(url: URL?)
}

class PlayWorkoutPresenter: IPlayWorkoutPresenter {
    unowned var view: IPlayWorkoutView!
    var user: UserModel
    var isTimerPlay: Bool = false
    
    private var currentActiveExcersice: Int = 0
    private var totalNumberOfEx: String = ""
    private var viewState: PlayWorkoutViewState = .inProgress
    private let infoService: ISensentiveInfoService
    private let databaseService: IDatabaseService
    private let networkService: INetworkService
    private var currentActiveLevel: Skill
    private let workout: WorkoutDTO
    private var activeExcercisesDTO: [ExerciseDTO] = []
    private var excerciseDataSource: [ExerciseModel] = [ExerciseModel.empty]

    init(
         infoService: ISensentiveInfoService,
         databaseService: IDatabaseService,
         networkService: INetworkService,
         workout: WorkoutDTO
    ) {
        self.networkService = networkService
        self.infoService = infoService
        self.databaseService = databaseService
        self.user = databaseService.getUserModel()
        let currentlevel = workout.choosenUserLevel ?? databaseService.getUserModel().level
        self.currentActiveLevel = currentlevel
        self.workout = workout
        var excerciseDataSource: [ExerciseDTO] = []
        switch currentlevel {
        case .beginner: 
            excerciseDataSource = workout.excercise.level0
        case .champion:
            excerciseDataSource = workout.excercise.level1
        case .expert:
            excerciseDataSource = workout.excercise.level2
        case .expertPlus: break
        }
        self.activeExcercisesDTO = excerciseDataSource
        self.excerciseDataSource += excerciseDataSource.map({ excDTO in
            return ExerciseModel(excercise: excDTO.name,
                                 approach: String(excDTO.approach),
                                 time: String(excDTO.time),
                                 repetition: String(excDTO.repetition),
                                 totalTime:  String("\(excDTO.totalTime / 60):\(excDTO.totalTime % 60)"),
                                 videoUrl: excDTO.videoLink,
                                 isActiveNow: excDTO == excerciseDataSource.first
            )
        })
    }
    
    func attachView(_ view: IPlayWorkoutView) {
        self.view = view
    }
    
    func startExercise() {
        guard viewState != .finished else { view.goHomeScreen() ; return }
        excerciseDataSource[safe: currentActiveExcersice]?.isActiveNow = false
        currentActiveExcersice += 1
        guard currentActiveExcersice <= excerciseDataSource.count - 1
        else {
            view?.stopTimer()
            addHistory()
            return
        }
        let nextExercise = excerciseDataSource[safe: currentActiveExcersice]
        nextExercise?.isActiveNow = true
        view?.playVideo(url: URL(string: nextExercise?.videoUrl ?? ""))
        view.setupActiveDataSource(exersice: excerciseDataSource, numberOfActiveEx: "\(currentActiveExcersice)")
    }
    
    func addHistory() {
        view.showSendingLoader(togle: true)
        networkService.addWorkOutHistory(userId: user.userId,
                                         workoutId: workout.id,
                                         workoutDate: workout.date) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let historyId):
                    strongSelf.viewState = .finished
                    strongSelf.savePoints()
                    strongSelf.showFinishView()
                    strongSelf.databaseService.savePassedWorkoutHistory(
                        model: WorkoutHistoryModel(id: historyId,
                                                   type: strongSelf.workout.type,
                                                   chooseLevel: strongSelf.currentActiveLevel,
                                                   passedTime: Date().toString(.YYYYMMDDTHHMMSS),
                                                   earnedPoints: String(strongSelf.currentActiveLevel.points),
                                                   trainingTime: strongSelf.view.trainingTime,
                                                   totalNumberOfEx: strongSelf.totalNumberOfEx,
                                                   date: strongSelf.workout.date.toDate(withFormat: .YYYYMMDDTHHMMSS)),
                        completion: {_ in})
                    NotificationCenter.default.post(name: Notification.Name(NotificationsConstants.userStatusNeedToUpdate),
                                                    object: nil)
                case .failure(let failure):
                    strongSelf.view.showSendingLoader(togle: false)
                    strongSelf.view.showError(message: failure.textToDisplay)
                }
            }
        }
    }
    
    private func savePoints() {
        databaseService.updateUserPoints(databaseService.getUserModel().userPoints + currentActiveLevel.points, completionHandler: {_ in})
    }
    
    private func showFinishView() {
        let name: String = workout.type
        let totalNumberOfExc: Int = excerciseDataSource.count - 1
        totalNumberOfEx = String(totalNumberOfExc)
        var totalTrainingTime: Int = 0
        //        String("\(totalTrainingTime / 60):\(totalTrainingTime % 60)"
        let pointsEarned: String = String(currentActiveLevel.points)
        activeExcercisesDTO.forEach { model in
            totalTrainingTime += model.totalTime
        }
        
        let defaultAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.white
        ] as [NSAttributedString.Key : Any]
        let lowAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.orange
        ] as [NSAttributedString.Key : Any]

        let attributedStringComponents = [
            NSAttributedString(string: "\(name) / ",
                                     attributes: defaultAttributes),
            NSAttributedString(string: user.level.rawValue.capitalized,
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
                         value: NSAttributedString(string: String(totalNumberOfExc),
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ])),
            .totalTrainingTime(title: NSAttributedString(string: "Total training time",
                                                         attributes: [
                                                          NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                          NSAttributedString.Key.foregroundColor : UIColor.white,
                                                         ]),
                               value: NSAttributedString(string: view.trainingTime,
                                                         attributes: [
                                                          NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                          NSAttributedString.Key.foregroundColor : UIColor.white,
                                                         ])),
            .pointEarned(title: NSAttributedString(string: "Points earned",
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ]),
                         value: NSAttributedString(string: pointsEarned,
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.AppCollors.orange,
                                                   ]))
        ]
        view.goToSessionFinishedScreen(info: result)
    }
    
    func getExcercise() -> [ExerciseModel] {
        return excerciseDataSource
    }
}
