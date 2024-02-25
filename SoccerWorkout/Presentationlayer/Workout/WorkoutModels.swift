//
//  WorkoutModels.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import Foundation

enum WorkoutState {
    case all
    case history
}

class WorkoutViewModel {
    var date: Date
    var workouts: [HomeViewModel]
    
    init(date: Date, workouts: [HomeViewModel]) {
        self.date = date
        self.workouts = workouts
    }
}

struct WorkoutDTO {
    var date: Date
    var type: String
    var excercise: [[ExerciseDTO]]
}

struct ExerciseDTO {
    var name: String
    var approach: Int //a
    var time: Int // t
    var repetition: Int //r
    var totalTime: Int //t
    var videoLink: String? 
}
