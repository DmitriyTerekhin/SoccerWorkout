//
//  HomeModels.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import Foundation

enum WorkoutType {
    case Leg
    case Running
    case GoalkeeperTraining
    case StrikerTraining
    case underfind(type: String)
    
    init(rawValue: String) {
        switch rawValue {
        case "Leg workout": self = .Leg
        case "Running workout": self = .Running
        case "Goalkeeper training": self = .GoalkeeperTraining
        case "Striker training": self = .StrikerTraining
        default: self = .underfind(type: rawValue)
        }
    }
    
    var title: String {
        switch self {
        case .Leg:
            return "Leg workout"
        case .Running:
            return "Running workout"
        case .GoalkeeperTraining:
            return "Goalkeeper training"
        case .StrikerTraining:
            return "Striker training"
        case .underfind(let type):
            return type
        }
    }
}

struct HomeModel {
    let workoutType: WorkoutType
    let time: Date
}

class HomeViewModel {
    var id: Int
    var date: Date?
    var title: NSAttributedString
    var subtitle: NSAttributedString
    
    init(id: Int, date: Date?, title: NSAttributedString, subtitle: NSAttributedString) {
        self.id = id
        self.date = date
        self.title = title
        self.subtitle = subtitle
    }
}

enum HomeHeaderState {
    case currentActive(name: String, date: Date)
    case allDone
}

struct LocalNotification {
    var identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    init?(fromDB: LocalNotificationsDB?) {
        guard let fromDB = fromDB else { return nil }
        self.identifier = fromDB.identifier
    }
}
