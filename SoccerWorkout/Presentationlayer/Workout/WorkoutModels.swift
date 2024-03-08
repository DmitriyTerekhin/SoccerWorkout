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

class WorkoutHistorySectionViewModel {
    var date: Date
    var workouts: [WorkoutHistoryViewModel]
    
    init(date: Date, workouts: [WorkoutHistoryViewModel]) {
        self.date = date
        self.workouts = workouts
    }
}

class WorkoutViewModel {
    var date: Date
    var workouts: [HomeViewModel]
    
    init(date: Date, workouts: [HomeViewModel]) {
        self.date = date
        self.workouts = workouts
    }
}

class WorkoutDTO: Equatable {
    static func == (lhs: WorkoutDTO, rhs: WorkoutDTO) -> Bool {
        return lhs.id == rhs.id
        && lhs.excercise == rhs.excercise
    }
    
    var id: Int
    var date: String
    var type: String
    var choosenUserLevel: Skill?
    var excercise: ExerciseLevels
    var timeStart: Date? {
        return date.toDate(withFormat: .YYYYMMDDTHHMMSS)
    }
    
    init(id: Int, date: String, type: String, excercise: ExerciseLevels) {
        self.id = id
        self.date = date
        self.type = type
        self.excercise = excercise
    }
}

struct ExerciseLevels: Equatable {
    var level0: [ExerciseDTO]
    var level1: [ExerciseDTO]
    var level2: [ExerciseDTO]
}

struct ExerciseDTO: Equatable {
    var id: String
    var name: String
    var approach: Int //a
    var time: Int // t
    var repetition: Int //r
    var totalTime: Int //t
    var videoLink: String? 
}

struct WorkoutHistoryViewModel {
    var id: Int
    var title: NSAttributedString
    var subtitle: NSAttributedString
    var points: String
    var totalNumberOfEx: String
    var totalTrainingTime: String
    var date: Date?
    var wasPassed: Bool
}
