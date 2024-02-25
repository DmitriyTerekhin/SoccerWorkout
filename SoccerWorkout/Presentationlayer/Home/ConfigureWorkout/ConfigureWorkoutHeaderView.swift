//
//  ConfigureWorkoutHeaderView.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class ConfigureWorkoutHeaderView: UIView {
    
    private enum Constants {
        static let beginner = "Beginner"
        static let champion = "Champion"
        static let expert = "Expert"
    }
    
    private let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    private let topStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 6
        return sv
    }()
    private let labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = -2
        return sv
    }()
    private let buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    private let topTitleLabel = UILabel()
    private let bottomDescriptionLabel = UILabel()
    
    private let notificationsButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setImage(UIImage(named: "Notification")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private let beginnerButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(Constants.beginner, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .AppCollors.orange
        return btn
    }()
    
    private let championButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(Constants.champion, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private let expertButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(Constants.expert, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentActiveSkill(activeSkill: Skill) {
        switch activeSkill {
        case .beginner:
            beginnerButton.changeActiveStatus(isActive: true)
            championButton.changeActiveStatus(isActive: false)
            expertButton.changeActiveStatus(isActive: false)
        case .champion:
            beginnerButton.changeActiveStatus(isActive: false)
            championButton.changeActiveStatus(isActive: true)
            expertButton.changeActiveStatus(isActive: false)
        case .expert:
            beginnerButton.changeActiveStatus(isActive: false)
            championButton.changeActiveStatus(isActive: false)
            expertButton.changeActiveStatus(isActive: true)
        }
    }
    
    private func setupView() {
        backgroundColor = UIColor(netHex: 0x211F1F)
        
        let title = "Leg workout"
        let subtitle = "Tomorrow, 11 Fed 2023 / 21:00 am"
        let titleAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.white
        ] as [NSAttributedString.Key : Any]
        
        // Subtitle
        let dateAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.defaultGray
        ] as [NSAttributedString.Key : Any]
        
        topTitleLabel.attributedText = NSAttributedString(string: title, attributes: titleAttributes)
        bottomDescriptionLabel.attributedText = NSAttributedString(string: subtitle, attributes: dateAttributes)
        
        layer.cornerRadius = 24
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leftAnchor.constraint(equalTo: mainStackView.superview!.leftAnchor, constant: 16).isActive = true
        mainStackView.topAnchor.constraint(equalTo: mainStackView.superview!.topAnchor, constant: 16).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: mainStackView.superview!.rightAnchor, constant: -16).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainStackView.superview!.bottomAnchor, constant: -16).isActive = true
        
        mainStackView.addArrangedSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        topStackView.addArrangedSubview(labelsStackView)
        labelsStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 220).isActive = true
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.addArrangedSubview(topTitleLabel)
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.addArrangedSubview(bottomDescriptionLabel)
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.addArrangedSubview(spaceView)
        topStackView.addArrangedSubview(notificationsButton)
        notificationsButton.translatesAutoresizingMaskIntoConstraints = false
        notificationsButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        notificationsButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        mainStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonWidth = (UIScreen.main.bounds.width - 16*2 - 8*2)/3
        buttonsStackView.addArrangedSubview(beginnerButton)
        beginnerButton.translatesAutoresizingMaskIntoConstraints = false
        beginnerButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        beginnerButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buttonsStackView.addArrangedSubview(championButton)
        championButton.translatesAutoresizingMaskIntoConstraints = false
        championButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        championButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        buttonsStackView.addArrangedSubview(expertButton)
        expertButton.translatesAutoresizingMaskIntoConstraints = false
        expertButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        expertButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}
