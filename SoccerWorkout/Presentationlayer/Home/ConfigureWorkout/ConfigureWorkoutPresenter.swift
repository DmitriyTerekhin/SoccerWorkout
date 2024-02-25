//
//  ConfigureWorkoutPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import Foundation

protocol IConfigureWorkoutPresenter: AnyObject {
    var excerciseDataSource: [ExerciseModel] { get }
}
protocol IConfigureWorkoutView: AnyObject {}

class ConfigureWorkoutPresenter: IConfigureWorkoutPresenter {
    var excerciseDataSource: [ExerciseModel] = [
        ExerciseModel.empty,
        ExerciseModel(excercise: "Leg warm-up",
                      approach: "10",
                      time: "2:00",
                      repetition: "5",
                      totalTime: "10:00"
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
}
