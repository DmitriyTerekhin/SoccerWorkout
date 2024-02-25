//
//  ConfigureWorkoutView.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class ConfigureWorkoutView: UIView {
    
    let configureHeaderView = ConfigureWorkoutHeaderView()
    
    let tableView: UITableView = {
        let tbl = UITableView()
        tbl.registerCell(reusable: WorkoutExerciseTableViewCell.self)
        tbl.backgroundColor = .clear
        tbl.separatorStyle = .none
        tbl.showsVerticalScrollIndicator = false
        tbl.isScrollEnabled = false
        tbl.contentInset.top = 32
        tbl.rowHeight = UITableView.automaticDimension
        return tbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .AppCollors.background
        addSubview(configureHeaderView)
        configureHeaderView.centerXAnchor.constraint(equalTo: configureHeaderView.superview!.centerXAnchor).isActive = true
        configureHeaderView.topAnchor.constraint(equalTo: configureHeaderView.superview!.safeTopAnchor, constant: 32).isActive = true
        configureHeaderView.translatesAutoresizingMaskIntoConstraints = false
        configureHeaderView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        configureHeaderView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: configureHeaderView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableView.superview!.safeBottomAnchor).isActive = true
    }
}
