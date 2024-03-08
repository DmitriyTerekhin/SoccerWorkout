//
//  PlayWorkoutView.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import UIKit
import Kingfisher
import AVFoundation
import AVKit

class PlayWorkoutView: UIView {
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var playerViewController = AVPlayerViewController()
    
    var trainingTime: String {
        return timerView.currentTime
    }
    
    private let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "WorkoutDefaultPic")
        iv.clipsToBounds = true
        iv.alpha = 0
        return iv
    }()
    
    private let loadingLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white.withAlphaComponent(0.2)
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.text = "Loading..."
        return lbl
    }()
    
    private let conturView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 16
        view.backgroundColor = .clear
        return view
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        return sv
    }()
    
    private let startButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setImage(UIImage(named: "Play")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.changeActiveStatus(isActive: true)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private let timerView = TimerView()
    private let statusView = StatusView()
    let botttomView = PlayWorkoutBottomView(cornerRadius: 16,
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
        tbl.showsVerticalScrollIndicator = false
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
        botttomView.completeButton.showLoader(toggle: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 0.3) {
                self.botttomView.changeStackViewWidth(248)
                self.botttomView.numberLabel.isHidden = true
                self.botttomView.completeButton.setTitle("Complete", for: .normal)
                self.workoutFinishedView.alpha = 1
            }
        }
    }
    
    func configureVideoPlayer(with videoURL: URL?) {
        guard let videoURL = videoURL else {
            playerImageView.alpha = 1
            loadingLabel.alpha = 0
            conturView.alpha = 0
            return
        }
        loadingLabel.alpha = 1
        loadingLabel.alpha = 1
        playerImageView.alpha = 0
//        let videoURL = URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4")!
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(origin: CGPoint(x: 10, y: 0),
                                   size: CGSize(width: conturView.bounds.width - 20,
                                                height: conturView.bounds.height))
        conturView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func showActiveNumberExcercise(number: String) {
        botttomView.numberLabel.text = "# " + number
    }
    
    func setupImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        playerImageView.kf.setImage(with: url)
    }
    
    func playOrStopTimer(play: Bool) {
        if play {
            player?.play()
            startButton.setImage(UIImage(named: "Pause")?.withRenderingMode(.alwaysOriginal), for: .normal)
            timerView.playTimer()
        } else {
            player?.pause()
            startButton.setImage(UIImage(named: "Play")?.withRenderingMode(.alwaysOriginal), for: .normal)
            timerView.stopTimer()
        }
    }

    private func setupView() {
        startButton.addTarget(nil, action: #selector(PlayWorkoutViewController.playButtonTapped), for: .touchUpInside)
        botttomView.completeButton.addTarget(nil,
                                             action: #selector(PlayWorkoutViewController.completeExcersiceTapped),
                                             for: .touchUpInside)
        timerView.changeNumbersColor(.white)
        backgroundColor = .AppCollors.background
        addSubview(playerImageView)
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        playerImageView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        playerImageView.centerXAnchor.constraint(equalTo: playerImageView.superview!.centerXAnchor).isActive = true
        playerImageView.heightAnchor.constraint(equalToConstant: 218).isActive = true
        playerImageView.topAnchor.constraint(equalTo: playerImageView.superview!.safeTopAnchor, constant: 32).isActive = true
        
        addSubview(conturView)
        conturView.translatesAutoresizingMaskIntoConstraints = false
        conturView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        conturView.centerXAnchor.constraint(equalTo: conturView.superview!.centerXAnchor).isActive = true
        conturView.heightAnchor.constraint(equalToConstant: 218).isActive = true
        conturView.topAnchor.constraint(equalTo: conturView.superview!.safeTopAnchor, constant: 32).isActive = true
        
        conturView.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.centerYAnchor.constraint(equalTo: loadingLabel.superview!.centerYAnchor).isActive = true
        loadingLabel.centerXAnchor.constraint(equalTo: loadingLabel.superview!.centerXAnchor).isActive = true
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 330).isActive = true
        stackView.centerXAnchor.constraint(equalTo: stackView.superview!.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: playerImageView.bottomAnchor, constant: 16).isActive = true
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
    
    func setupUserSkill(_ skill: Skill, points: Int) {
        statusView.setupUserSkill(skill: skill, points: points)
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
