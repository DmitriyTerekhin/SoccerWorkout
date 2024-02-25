//
//  PlayWorkoutModels.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import Foundation

enum PlayWorkoutViewState {
    case inProgress
    case finished
}

enum FinishedResultstTypes {
    case excerciseName(title: NSAttributedString)
    case totalNumber(title: NSAttributedString, value: NSAttributedString)
    case totalTrainingTime(title: NSAttributedString, value: NSAttributedString)
    case pointEarned(title: NSAttributedString, value: NSAttributedString)
    
    var title: NSAttributedString {
        switch self {
        case .excerciseName(let title):
            return title
        case .totalNumber(let title, let value):
            return title
        case .totalTrainingTime(let title, let value):
            return title
        case .pointEarned(let title, let value):
            return title
        }
    }
    
    var value: NSAttributedString? {
        switch self {
        case .excerciseName(let title):
            return nil
        case .totalNumber(let title, let value):
            return value
        case .totalTrainingTime(let title, let value):
            return value
        case .pointEarned(let title, let value):
            return value
        }
    }
}
