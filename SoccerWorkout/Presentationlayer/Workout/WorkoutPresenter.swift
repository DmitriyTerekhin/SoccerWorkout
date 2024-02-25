//
//  WorkoutPresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

protocol IWorkoutPresenter: AnyObject {
    func attachView(_ view: IWorkoutView)
    func getTrainings() -> [WorkoutViewModel]
}

protocol IWorkoutView: AnyObject {
    
}

class WorkoutPresenter: IWorkoutPresenter {
    
    
    private let skillType: Skill = .beginner
    private let networkService: INetworkService
    private let training: [HomeModel] = [
        HomeModel(workoutType: .Leg,
                  time: Date()),
        HomeModel(workoutType: .Running,
                  time: Date()),
        HomeModel(workoutType: .GoalkeeperTraining,
                  time: Date()),
        HomeModel(workoutType: .StrikerTraining,
                  time: Date())
    ]
    
    unowned var view: IWorkoutView!
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func attachView(_ view: IWorkoutView) {
        self.view = view
    }
    
    func getTrainings() -> [WorkoutViewModel] {
        var workoutModels: [WorkoutViewModel] = []
        
        training.forEach { model in
            let title = "\(model.workoutType.rawValue) /"
            let titleAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.white
            ] as [NSAttributedString.Key : Any]
            
            let skillAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.orange
            ] as [NSAttributedString.Key : Any]
            
            let titleAttributedStringComponents = [
                NSAttributedString(string: title,
                                         attributes: titleAttributes),
                NSAttributedString(string: skillType.rawValue.capitalized,
                                         attributes: skillAttributes)
            ] as [AttributedStringComponent]
            
            // Subtitle
            let dateString = model.time.toString("EEEE, dd MMM YYYY / HH:mm a")
            let dateAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.defaultGray
            ] as [NSAttributedString.Key : Any]
            
            let homeModel = HomeViewModel(date: model.time,
                                          title: NSAttributedString(from: titleAttributedStringComponents,
                                                                    defaultAttributes: [:])!,
                                          subtitle: NSAttributedString(string: dateString, attributes: dateAttributes))
            
            if let lastWorkout = workoutModels.last,
               let lastWorkoutInDay = lastWorkout.workouts.last,
               Calendar.current.isDate(lastWorkoutInDay.date, equalTo: model.time,
                                       toGranularity: .day) {
                lastWorkout.workouts.append(homeModel)
            } else {
                workoutModels.append(
                    WorkoutViewModel(date: model.time,
                                     workouts: [
                                        homeModel
                                     ])
                )
            }
        }
        return workoutModels
    }
}
