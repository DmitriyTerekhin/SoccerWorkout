//
//  HomeView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class HomeView: UIView {
    
    let tableView: UITableView = {
        let tbl = UITableView()
        tbl.registerCell(reusable: WorkoutTableViewCell.self)
        tbl.backgroundColor = .AppCollors.background
        tbl.allowsSelection = false
        tbl.contentInset.bottom = 100
        tbl.delaysContentTouches = false
        return tbl
    }()
    
    private let headerView = HomeHeaderView()
    private let statusView = StatusView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        headerView.currentActiveWorkoutView.startButton.addTarget(nil, action: #selector(HomeViewController.playButtonTapped), for: .touchUpInside)
        backgroundColor = .AppCollors.background
        addSubview(tableView)
        
        tableView.setAndLayoutTableHeaderView(header: headerView)
        
        tableView.topAnchor.constraint(equalTo: tableView.superview!.safeTopAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addStatus(to navBar: UINavigationBar?) {
        guard let navBar = navBar else { return }
        navBar.addSubview(statusView)
        statusView.bottomAnchor.constraint(equalTo: statusView.superview!.bottomAnchor, constant: 0).isActive = true
        statusView.rightAnchor.constraint(equalTo: statusView.superview!.rightAnchor, constant: -16).isActive = true
        statusView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        statusView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        statusView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
