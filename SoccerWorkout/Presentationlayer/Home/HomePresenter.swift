//
//  HomePresenter.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

protocol IHomePresenter: AnyObject {
    func getTrainings() -> [HomeViewModel]
}

class HomePresenter: IHomePresenter {
    
    private let networkService: INetworkService
    private let skillType: Skill = .beginner
    
    private let training: [HomeModel] = [
        HomeModel(workoutType: .Leg,
                  time: Date()),
        HomeModel(workoutType: .Running,
                  time: Date()),
        HomeModel(workoutType: .GoalkeeperTraining,
                  time: Date()),
        HomeModel(workoutType: .StrikerTraining,
                  time: Date()),
    ]
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func loadHomeList() {
        networkService.loadHistory() // Here need to change
    }
    
    func getTrainings() -> [HomeViewModel] {
        return training.map { model in
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
            
            return HomeViewModel(date: model.time,
                                 title: NSAttributedString(from: titleAttributedStringComponents, defaultAttributes: [:])!,
                                 subtitle: NSAttributedString(string: dateString, attributes: dateAttributes))
        }
    }
}
