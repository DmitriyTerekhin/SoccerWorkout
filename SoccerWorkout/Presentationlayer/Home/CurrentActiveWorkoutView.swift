//
//  CurrentActiveWorkoutView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class CurrentActiveWorkoutView: UIView {
    
    override var bounds: CGRect {
        didSet {
            guard !bounds.isEmpty else { return }
            setGradientBackground()
        }
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
    private let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        return sv
    }()
    private let labelsStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .leading
        sv.axis = .vertical
        sv.spacing = -2
        return sv
    }()
    private let topTitleLabel = UILabel()
    private let bottomDescriptionLabel = UILabel()
    let settingButtons: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setImage(UIImage(named: "ActiveSettings")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()
    let notificationsButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setImage(UIImage(named: "Notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .AppCollors.defaultGray
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    let startButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("Start now", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.changeActiveStatus(isActive: true)
        return btn
    }()
    
    private let timerView = TimerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(workoutName: "", date: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: NSAttributedString, subtitle: NSAttributedString) {
        topTitleLabel.attributedText = title
        bottomDescriptionLabel.attributedText = subtitle
    }
    
    func setupTimer(toDate: Date) {
        let interval = toDate - Date()
        timerView.startOtpTimer(minutes: interval.minute ?? 0)
    }
    
    func setupView(workoutName: String, date: String) {
        
        let title = workoutName
        let subtitle = date
       
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.paragraphSpacingBefore = 4
        
        let titleAttributes: [NSAttributedString.Key : Any]  = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.white,
            .paragraphStyle: style
        ] as [NSAttributedString.Key : Any]
        
        // Subtitle
        let dateAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.defaultGray,
            .paragraphStyle: style
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
        labelsStackView.addArrangedSubview(topTitleLabel)
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.addArrangedSubview(bottomDescriptionLabel)
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.addArrangedSubview(labelsStackView)
        labelsStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 208).isActive = true
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.addArrangedSubview(notificationsButton)
        notificationsButton.translatesAutoresizingMaskIntoConstraints = false
        notificationsButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        notificationsButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        topStackView.addArrangedSubview(settingButtons)
        settingButtons.translatesAutoresizingMaskIntoConstraints = false
        settingButtons.widthAnchor.constraint(equalToConstant: 48).isActive = true
        settingButtons.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        mainStackView.addArrangedSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        bottomStackView.addArrangedSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        bottomStackView.addArrangedSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.widthAnchor.constraint(equalToConstant: 102).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
    }
    
    func setGradientBackground() {

        let colorTop =  UIColor(netHex: 0x211F1F).cgColor
        let colorBottom = UIColor(netHex: 0x1C1B1B).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 20
                
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

private extension Date {

    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

}
