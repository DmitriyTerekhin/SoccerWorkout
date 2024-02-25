//
//  WorkoutView.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class WorkoutView: UIView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    private let allButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("All", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.backgroundColor = .AppCollors.orange
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private let historyButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("History", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private let statusView = StatusView()
    
    let tableView: UITableView = {
        let tbl = UITableView()
        tbl.registerCell(reusable: WorkoutTableViewCell.self)
        tbl.registerFooterHeader(reusable: WorkoutSectionHeaderView.self)
        tbl.sectionHeaderHeight = UITableView.automaticDimension
        tbl.backgroundColor = .AppCollors.background
        tbl.allowsSelection = false
        tbl.contentInset.bottom = 100
        return tbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(for viewState: WorkoutState) {
        historyButton.changeActiveStatus(isActive: viewState == .history)
        allButton.changeActiveStatus(isActive: viewState == .all)
    }
    
    private func setupView() {
        backgroundColor = .AppCollors.background
        allButton.addTarget(nil,
                            action: #selector(WorkoutViewController.allButtonTapped),
                            for: .touchUpInside)
        historyButton.addTarget(nil,
                            action: #selector(WorkoutViewController.historyButtonTapped),
                            for: .touchUpInside)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 216).isActive = true
        stackView.leftAnchor.constraint(equalTo: stackView.superview!.leftAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: stackView.superview!.safeTopAnchor, constant: 25).isActive = true
        stackView.addArrangedSubview(allButton)
        allButton.translatesAutoresizingMaskIntoConstraints = false
        allButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
        allButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.addArrangedSubview(historyButton)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        historyButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
        historyButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25).isActive = true
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
