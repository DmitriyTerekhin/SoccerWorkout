//
//  PlayWorkoutPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import Foundation
import UIKit

protocol IPlayWorkoutPresenter: AnyObject {
    func attachView(_ view: IPlayWorkoutView)
    func getExcercise() -> [ExerciseModel]
    func completeExercise()
}

protocol IPlayWorkoutView: AnyObject {
    func setupActiveDataSource(exersice: [ExerciseModel])
    func goToSessionFinishedScreen(info: [FinishedResultstTypes])
    func goHomeScreen()
}

class PlayWorkoutPresenter: IPlayWorkoutPresenter {
    unowned var view: IPlayWorkoutView!
    private var currentActiveExcersice: Int = 1
    private var viewState: PlayWorkoutViewState = .inProgress
    private var excerciseDataSource: [ExerciseModel] = [
        ExerciseModel.empty,
        ExerciseModel(excercise: "Leg warm-up",
                      approach: "10",
                      time: "2:00",
                      repetition: "5",
                      totalTime: "10:00",
                      isActiveNow: true
                     ),
        ExerciseModel(excercise: "Warm-up for arms",
                      approach: "15",
                      time: "2:30",
                      repetition: "5",
                      totalTime: "14:30"),
        ExerciseModel(excercise: "Shots on goal from 10",
                      approach: "10",
                      time: "5:00",
                      repetition: "2",
                      totalTime: "10:00"),
        ExerciseModel(excercise: "Running from gate",
                      approach: "1",
                      time: "5:00",
                      repetition: "3",
                      totalTime: "15:00"),
        ExerciseModel(excercise: "Shots on goal from 10 meters",
                      approach: "10",
                      time: "5:00",
                      repetition: "2",
                      totalTime: "10:00")
    ]

    
    func attachView(_ view: IPlayWorkoutView) {
        self.view = view
    }
    
    func completeExercise() {
        guard viewState != .finished else { view.goHomeScreen() ; return }
        excerciseDataSource[safe: currentActiveExcersice]?.isActiveNow = false
        currentActiveExcersice += 1
        guard currentActiveExcersice <= excerciseDataSource.count - 1
        else {
            viewState = .finished
            showFinishView()
            return
        }
        excerciseDataSource[safe: currentActiveExcersice]?.isActiveNow = true
        view.setupActiveDataSource(exersice: excerciseDataSource)
    }
    
    private func showFinishView() {
        
        let defaultAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.white
        ] as [NSAttributedString.Key : Any]
        let lowAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.orange
        ] as [NSAttributedString.Key : Any]

        let attributedStringComponents = [
            NSAttributedString(string: "Leg workout / ",
                                     attributes: defaultAttributes),
            NSAttributedString(string: "Beginner",
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
                         value: NSAttributedString(string: "22",
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ])),
            .totalTrainingTime(title: NSAttributedString(string: "Total training time",
                                                         attributes: [
                                                          NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                          NSAttributedString.Key.foregroundColor : UIColor.white,
                                                         ]),
                               value: NSAttributedString(string: "60:00",
                                                         attributes: [
                                                          NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                          NSAttributedString.Key.foregroundColor : UIColor.white,
                                                         ])),
            .pointEarned(title: NSAttributedString(string: "Points earned",
                                                   attributes: [
                                                    NSAttributedString.Key.font : UIFont(font: .PoppinsMedium, size: 14),
                                                    NSAttributedString.Key.foregroundColor : UIColor.white,
                                                   ]),
                         value: NSAttributedString(string: "+1",
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
