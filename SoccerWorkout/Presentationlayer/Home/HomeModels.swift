//
//  HomeModels.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import Foundation

enum WorkoutType: String {
    case Leg
    case Running
    case GoalkeeperTraining
    case StrikerTraining
}

struct HomeModel {
    let workoutType: WorkoutType
    let time: Date
}

struct HomeViewModel {
    var date: Date
    var title: NSAttributedString
    var subtitle: NSAttributedString
}
