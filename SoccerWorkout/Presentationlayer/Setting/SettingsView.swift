//
//  SettingsView.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class SettingsView: ChooseSkillView {
    
    let tableView: UITableView = {
        let tbl = UITableView()
        tbl.registerCell(reusable: SettingsTableViewCell.self)
        tbl.backgroundColor = .clear
        tbl.separatorStyle = .none
        tbl.showsVerticalScrollIndicator = false
        tbl.isScrollEnabled = false
        tbl.rowHeight = UITableView.automaticDimension
        return tbl
    }()
    
    let goalView = ChooseGoalSettingsButtonView()
    
    override func setupView() {
        mainStackView.addArrangedSubview(goalView)
        mainStackView.setCustomSpacing(32, after: goalView)
        goalView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        goalView.heightAnchor.constraint(equalToConstant: 78).isActive = true
        goalView.translatesAutoresizingMaskIntoConstraints = false
        super.setupView()
        continueButton.isHidden = true
        skillsStackView.isHidden = true
        buttonsStackView.isHidden = true
        skillImageViewTopAnchor.isActive = true
        mainStackViewCenterYAnchor.isActive = false
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32).isActive = true
        tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableView.superview!.safeBottomAnchor, constant: -40).isActive = true
    }
    
    
    override func setupDelegates() {
        goalView.editButton.addTarget(nil, action: #selector(SettingsViewController.changeGoalLevelTapped), for: .touchUpInside)
        firstSkillButton.addTarget(nil, action: #selector(SettingsViewController.beginnerTapped), for: .touchUpInside)
        secondSkillButton.addTarget(nil, action: #selector(SettingsViewController.championTapped), for: .touchUpInside)
        thirdSkillButton.addTarget(nil, action: #selector(SettingsViewController.expertTapped), for: .touchUpInside)
    }
    
    func setupUserSkill(_ skill: Skill, points: Int) {
        skillTapped(skill: skill, points: points)
        statusView.setupUserSkill(skill: skill, points: points)
        
        let defaultAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 18),
            .foregroundColor: UIColor.AppCollors.defaultGray
        ] as [NSAttributedString.Key : Any]
        let lowAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 18),
            .foregroundColor: UIColor.AppCollors.orange
        ] as [NSAttributedString.Key : Any]

        let attributedStringComponents = [
            NSAttributedString(string: ChooseSkillView.Constants.yourLevel,
                                     attributes: defaultAttributes),
            NSAttributedString(string: skill.title.capitalized,
                                     attributes: lowAttributes)
        ] as [AttributedStringComponent]
        yourlevelLabel.attributedText = NSAttributedString(from: attributedStringComponents,
                                                       defaultAttributes: [:])
    }
}
