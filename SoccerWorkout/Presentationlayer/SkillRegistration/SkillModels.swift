//
//  SkillModels.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import Foundation

enum Skill: String {
    case beginner
    case champion
    case expert
    case expertPlus
    
    init?(level: Int) {
        switch level {
        case 0: self = .beginner
        case 1: self = .champion
        case 2: self = .expert
        case 3: self = .expertPlus
        default:
            return nil
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "beginner": self = .beginner
        case "champion": self = .champion
        case "expert": self = .expert
        case "expertPlus": self = .expertPlus
        default: return nil
        }
    }
    
    var level: Int {
        switch self {
        case .beginner:
            return 0
        case .champion:
            return 1
        case .expert:
            return 2
        case .expertPlus:
            return 3
        }
    }
    
    var points: Int {
        switch self {
        case .beginner:
            return 1
        case .champion:
            return 2
        case .expert:
            return 3
        case .expertPlus:
            return 4
        }
    }
    
    var imageName: String {
        return rawValue.capitalized
    }
    
    var title: String {
        switch self {
        case .expertPlus:
            return "Expert+"
        default:
            return rawValue
        }
    }
}

struct UserModel {
    
    static let empty = UserModel(level: .beginner,
                                 userId: "",
                                 userPoints: 0)
    
    var level: Skill
    var userId: String
    var userPoints: Int
    var goalLevel: Skill?
    var goalTime: GoalTime?
    
    init(level: Skill, userId: String, userPoints: Int, goalLevel: Skill? = nil, goalTime: GoalTime? = nil) {
        self.level = level
        self.userId = userId
        self.userPoints = userPoints
        self.goalLevel = goalLevel
        self.goalTime = goalTime
    }
    
    init(from db: UserDB?) {
        guard let db = db else { self = UserModel.empty; return }
        self.level = Skill(level: Int(db.level)) ?? .beginner
        self.userId = db.userId
        self.userPoints = Int(db.points)
        self.goalLevel = Skill(level: Int(db.goalLevel))
        self.goalTime = GoalTime(rawValue: Int(db.goalTime))
    }
}
