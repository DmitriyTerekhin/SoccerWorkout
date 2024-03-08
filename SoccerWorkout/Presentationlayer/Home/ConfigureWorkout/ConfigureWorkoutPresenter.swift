//
//  ConfigureWorkoutPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import Foundation

protocol IConfigureWorkoutPresenter: AnyObject {
    func attachView(_ view: IConfigureWorkoutView)
    func skillTapped(skill: Skill)
    func notificationTapped()
    func backButtonTapped()
    func saveLevelForCurrentWorkout()
}
protocol IConfigureWorkoutView: AnyObject {
    func configureHeader(title: String, subtitle: String, for skill: Skill)
    func showActiveNotification(show: Bool)
    func updateExcercise(excercise: [ExerciseModel])
    func goBack()
    func askToSaveChanges()
}

class ConfigureWorkoutPresenter: IConfigureWorkoutPresenter {
    
    private let workout: WorkoutDTO
    private unowned var view: IConfigureWorkoutView!
    private let infoService: ISensentiveInfoService
    private let notificationService: INotificationService
    private let databaseService: IDatabaseService
    private var notificationIsActive: Bool = false
    private var currentActiveSkill: Skill
    weak var delegate: WorkoutDetailDelegate?
    
    init(
        workout: WorkoutDTO,
        infoService: ISensentiveInfoService,
        databaseService: IDatabaseService,
        notificationService: INotificationService,
        delegate: WorkoutDetailDelegate?
    ) {
        self.delegate = delegate
        self.notificationService = notificationService
        self.workout = workout
        self.infoService = infoService
        self.databaseService = databaseService
        self.currentActiveSkill = workout.choosenUserLevel ?? databaseService.getUserModel().level
    }
    
    func attachView(_ view: IConfigureWorkoutView) {
        self.view = view
        self.view.configureHeader(title: workout.type,
                                  subtitle: workout.timeStart?.getTrainingDateString() ?? "Underfind",
                                  for: currentActiveSkill)
        self.skillTapped(skill: currentActiveSkill)
        self.preapreNotification(wrktName: workout.type, timeStart: workout.timeStart)
    }
    
    func saveLevelForCurrentWorkout() {
        databaseService.saveWorkoutChoosenLevel(model: WorkoutModel(chooseLevel: currentActiveSkill,
                                                                    id: workout.id)) { _ in
            self.workout.choosenUserLevel = self.currentActiveSkill
            self.delegate?.workoutLevelWasChanged()
            self.view.goBack()
        }
    }
    
    func backButtonTapped() {
        if currentActiveSkill != (workout.choosenUserLevel ?? databaseService.getUserModel().level) {
            view.askToSaveChanges()
        } else {
            view.goBack()
        }
    }
    
    func notificationTapped() {
        guard
            let time = workout.timeStart
        else { return }
        notificationIsActive = !notificationIsActive
        if notificationIsActive {
            notificationService.setReminder(trainingName: workout.type, date: time) { _ in
                self.delegate?.notificationWasChanged()
            }
        } else {
            notificationService.removeCurrentReminder(trainingName: workout.type, date: time)
            delegate?.notificationWasChanged()
        }
        view.showActiveNotification(show: notificationIsActive)
    }
    
    private func preapreNotification(wrktName: String, timeStart: Date?) {
        guard let date = timeStart else { return }
        notificationIsActive = notificationService.isNotificationExist(trainingName: wrktName, date: date)
        view.showActiveNotification(show: notificationIsActive)
    }
    
    func skillTapped(skill: Skill) {
        currentActiveSkill = skill
        var exDTO: [ExerciseDTO] = []
        switch currentActiveSkill {
        case .beginner:
            exDTO = workout.excercise.level0
        case .champion:
            exDTO = workout.excercise.level1
        case .expert:
            exDTO = workout.excercise.level2
        default: break
        }
        
        view.updateExcercise(excercise: exDTO.map { exDTO in
            return ExerciseModel(excercise: exDTO.name,
                                 approach: String(exDTO.approach),
                                 time: String(exDTO.time),
                                 repetition: String(exDTO.repetition),
                                 totalTime: String(exDTO.totalTime))
        })
    }
}

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
}
