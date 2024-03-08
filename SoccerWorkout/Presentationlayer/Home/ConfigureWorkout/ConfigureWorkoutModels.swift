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
    var videoUrl: String?
    var isActiveNow: Bool
    
    init(excercise: String,
         approach: String,
         time: String,
         repetition: String,
         totalTime: String,
         videoUrl: String? = nil,
         isActiveNow: Bool = false) {
        self.isActiveNow = isActiveNow
        self.excercise = excercise
        self.approach = approach
        self.time = time
        self.repetition = repetition
        self.totalTime = totalTime
        self.videoUrl = videoUrl
    }
    
    func changeActiveExcercise(isActive: Bool) {
        self.isActiveNow = isActive
    }
}

struct WorkoutHistoryModel {
    var chooseLevel: Skill
    var passedTime: String
    var earnedPoints: String
    var trainingTime: String
    var totalNumberOfEx: String
    var date: Date?
    var type: String
    var id: Int
    
    init(id: Int, type: String, chooseLevel: Skill, passedTime: String, earnedPoints: String, trainingTime: String, totalNumberOfEx: String, date: Date?) {
        self.chooseLevel = chooseLevel
        self.id = id
        self.date = date
        self.earnedPoints = earnedPoints
        self.passedTime = passedTime
        self.trainingTime = trainingTime
        self.totalNumberOfEx = totalNumberOfEx
        self.type = type
    }
    
    init?(from db: WorkoutHistoryDB?) {
        guard
            let db = db,
            let level = Skill(rawValue: db.choosenLevel)
        else { return nil }
        chooseLevel = level
        passedTime = db.passedTime
        earnedPoints = db.earnedPoints
        trainingTime = db.trainingTime
        totalNumberOfEx = db.totalNumberOfEx
        type = db.type
        date = db.date
        id = Int(db.id)
    }
}

struct WorkoutModel {
    var chooseLevel: Skill
    var id: Int
    
    init(chooseLevel: Skill, id: Int) {
        self.chooseLevel = chooseLevel
        self.id = id
    }
    
    init?(from db: WorkoutDB?) {
        guard 
            let db = db,
            let level = Skill(level: Int(db.choosenLevel))
        else { return nil }
        chooseLevel = level
        id = Int(db.id)
    }
}
