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
    
    override func setupView() {
        super.setupView()
        continueButton.isHidden = true
        skillsStackView.isHidden = true
        skillImageViewTopAnchor.isActive = true
        mainStackViewCenterYAnchor.isActive = false
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32).isActive = true
        tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableView.superview!.safeBottomAnchor, constant: -40).isActive = true
    }
}
