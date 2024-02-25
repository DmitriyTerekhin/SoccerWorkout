//
//  PlayWorkoutView.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import UIKit

class PlayWorkoutView: UIView {
    
    private let trainingImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Training")
        return iv
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        return sv
    }()
    
    private let startButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("Start now", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.changeActiveStatus(isActive: true)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private let timerView = TimerView()
    private let statusView = StatusView()
    private let botttomView = PlayWorkoutBottomView(cornerRadius: 16,
                                                    colors: [
                                                        UIColor(netHex: 0x211F1F).cgColor,
                                                        UIColor(netHex: 0x1C1B1B).cgColor
                                                    ])
    
    private let workoutFinishedView = WorkoutFinishedView()
    
    let tableView: UITableView = {
        let tbl = UITableView()
        tbl.registerCell(reusable: WorkoutExerciseTableViewCell.self)
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
    
    func showFinishedView(info: [FinishedResultstTypes]) {
        workoutFinishedView.isHidden = false
        workoutFinishedView.configureView(info: info)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 0.3) {
                self.botttomView.changeStackViewWidth(248)
                self.botttomView.numberLabel.isHidden = true
                self.botttomView.completeButton.setTitle("Complete", for: .normal)
                self.workoutFinishedView.alpha = 1
            }
        }
    }

    private func setupView() {
        startButton.addTarget(nil, action: #selector(PlayWorkoutViewController.playButtonTapped), for: .touchUpInside)
        botttomView.completeButton.addTarget(nil,
                                             action: #selector(PlayWorkoutViewController.completeExcersiceTapped),
                                             for: .touchUpInside)
        timerView.changeNumbersColor(.white)
        backgroundColor = .AppCollors.background
        addSubview(trainingImageView)
        trainingImageView.translatesAutoresizingMaskIntoConstraints = false
        trainingImageView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        trainingImageView.centerXAnchor.constraint(equalTo: trainingImageView.superview!.centerXAnchor).isActive = true
        trainingImageView.heightAnchor.constraint(equalToConstant: 218).isActive = true
        trainingImageView.topAnchor.constraint(equalTo: trainingImageView.superview!.safeTopAnchor, constant: 32).isActive = true
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 330).isActive = true
        stackView.centerXAnchor.constraint(equalTo: stackView.superview!.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: trainingImageView.bottomAnchor, constant: 16).isActive = true
        stackView.addArrangedSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        stackView.addArrangedSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.widthAnchor.constraint(equalToConstant: 102).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(botttomView)
        botttomView.translatesAutoresizingMaskIntoConstraints = false
        botttomView.leftAnchor.constraint(equalTo: botttomView.superview!.leftAnchor).isActive = true
        botttomView.rightAnchor.constraint(equalTo: botttomView.superview!.rightAnchor).isActive = true
        botttomView.bottomAnchor.constraint(equalTo: botttomView.superview!.bottomAnchor).isActive = true
        botttomView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        
        addSubview(workoutFinishedView)
        workoutFinishedView.isHidden = true
        workoutFinishedView.alpha = 0
        workoutFinishedView.translatesAutoresizingMaskIntoConstraints = false
        workoutFinishedView.leftAnchor.constraint(equalTo: workoutFinishedView.superview!.leftAnchor).isActive = true
        workoutFinishedView.rightAnchor.constraint(equalTo: workoutFinishedView.superview!.rightAnchor).isActive = true
        workoutFinishedView.topAnchor.constraint(equalTo: workoutFinishedView.superview!.safeTopAnchor).isActive = true
        workoutFinishedView.bottomAnchor.constraint(equalTo: botttomView.topAnchor).isActive = true
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
