//
//  ConfigureWorkoutModels.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import Foundation

class ExerciseModel: Equatable {
    static func == (lhs: ExerciseModel, rhs: ExerciseModel) -> Bool {
        lhs.excercise == rhs.excercise
        && lhs.approach == rhs.approach
        && lhs.repetition == rhs.repetition
        && lhs.time == rhs.time
        && lhs.totalTime == rhs.totalTime
    }
    
    
    static let empty: ExerciseModel = ExerciseModel(excercise: "Exercise",
                                                    approach: "A",
                                                    time: "T",
                                                    repetition: "R",
                                                    totalTime: "TT")
    
    var excercise: String
    var approach: String
    var time: String
    var repetition: String
    var totalTime: String
    var isActiveNow: Bool
    
    init(excercise: String,
         approach: String,
         time: String,
         repetition: String,
         totalTime: String,
         isActiveNow: Bool = false) {
        self.isActiveNow = isActiveNow
        self.excercise = excercise
        self.approach = approach
        self.time = time
        self.repetition = repetition
        self.totalTime = totalTime
    }
    
    func changeActiveExcercise(isActive: Bool) {
        self.isActiveNow = isActive
    }
}
