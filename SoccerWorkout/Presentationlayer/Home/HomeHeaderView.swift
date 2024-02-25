//
//  HomeHeaderView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class HomeHeaderView: UIView {
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Workouts for today"
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 18)
        lbl.textColor = .white
        return lbl
    }()
    
    let currentActiveWorkoutView = CurrentActiveWorkoutView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .AppCollors.background
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleLabel.superview!.leftAnchor, constant: 16).isActive = true
        
        addSubview(currentActiveWorkoutView)
        currentActiveWorkoutView.translatesAutoresizingMaskIntoConstraints = false
        currentActiveWorkoutView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        currentActiveWorkoutView.centerXAnchor.constraint(equalTo: currentActiveWorkoutView.superview!.centerXAnchor, constant: 0).isActive = true
        currentActiveWorkoutView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        currentActiveWorkoutView.heightAnchor.constraint(equalToConstant: 162).isActive = true
        currentActiveWorkoutView.bottomAnchor.constraint(equalTo: currentActiveWorkoutView.superview!.bottomAnchor, constant: -16).isActive = true
        
    }
    
}
