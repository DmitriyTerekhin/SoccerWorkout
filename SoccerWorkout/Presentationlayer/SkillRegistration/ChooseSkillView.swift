//
//  ChooseSkillView.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

class ChooseSkillView: UIView {
    
    enum Constants {
        static let yourLevel = "Your level of training"
        static let beginner = "Beginner"
        static let champion = "Champion"
        static let expert = "Expert"
        static let description = "We will select workouts that correspond to your level, for each workout at a certain level you will receive a reward corresponding to the level"
    }
    
    let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 16
        return sv
    }()
    
    let buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let skillsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    private let beginnerLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    private let championLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    private let expertLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    let skillImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Beginner")
        return iv
    }()

    private let whistle1ImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "whistle")
        return iv
    }()
    
    private let whistle2ImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "whistle")
        return iv
    }()
    
    private let whistle3ImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "whistle")
        return iv
    }()
    
    let yourlevelLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 18)
        lbl.textColor = .AppCollors.defaultGray
        lbl.text = Constants.yourLevel
        return lbl
    }()
    
    let firstSkillButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(Constants.beginner, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return btn
    }()
    
    let secondSkillButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(Constants.champion, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    let thirdSkillButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(Constants.expert, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return btn
    }()
    
    let descriptionlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.description
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return lbl
    }()
    
    private let beginnerlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "*Beginner - 1"
        lbl.textColor = .AppCollors.defaultGray
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return lbl
    }()
    
    private let championlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "*Champion - 2"
        lbl.textColor = .AppCollors.defaultGray
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return lbl
    }()
    
    private let expertlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "*Expert - 3"
        lbl.textColor = .AppCollors.defaultGray
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return lbl
    }()
    
    let continueButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("Continue", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.changeActiveStatus(isActive: true)
        btn.changeGradientButtonState(isActive: false)
        return btn
    }()
    
    let statusView = StatusView()
    
    var skillImageViewTopAnchor = NSLayoutConstraint()
    var mainStackViewCenterYAnchor = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func skillTapped(skill: Skill, points: Int) {
        skillImageView.image = UIImage(named: skill.imageName)
        statusView.setupUserSkill(skill: skill, points: points)
        switch skill {
        case .beginner:
            firstSkillButton.changeActiveStatus(isActive: true)
            secondSkillButton.changeActiveStatus(isActive: false)
            thirdSkillButton.changeActiveStatus(isActive: false)
        case .champion:
            firstSkillButton.changeActiveStatus(isActive: false)
            secondSkillButton.changeActiveStatus(isActive: true)
            thirdSkillButton.changeActiveStatus(isActive: false)
        case .expert:
            firstSkillButton.changeActiveStatus(isActive: false)
            secondSkillButton.changeActiveStatus(isActive: false)
            thirdSkillButton.changeActiveStatus(isActive: true)
        case .expertPlus:
            firstSkillButton.changeActiveStatus(isActive: false)
            secondSkillButton.changeActiveStatus(isActive: false)
            thirdSkillButton.changeActiveStatus(isActive: false)
        }
    }
    
    func setupDelegates() {
        firstSkillButton.addTarget(nil, action: #selector(ChooseSkillViewController.beginnerTapped), for: .touchUpInside)
        secondSkillButton.addTarget(nil, action: #selector(ChooseSkillViewController.championTapped), for: .touchUpInside)
        thirdSkillButton.addTarget(nil, action: #selector(ChooseSkillViewController.expertTapped), for: .touchUpInside)
        continueButton.addTarget(nil, action: #selector(ChooseSkillViewController.continueTapped), for: .touchUpInside)
    }
    
    func setupView() {
        setupDelegates()
        backgroundColor = .AppCollors.background
        continueButton.changeDisablingState(isActive: false)
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leftAnchor.constraint(equalTo: mainStackView.superview!.leftAnchor, constant: 16).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: mainStackView.superview!.rightAnchor, constant: -16).isActive = true
        mainStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 546).isActive = true
        mainStackViewCenterYAnchor = mainStackView.centerYAnchor.constraint(equalTo: mainStackView.superview!.centerYAnchor)
        mainStackViewCenterYAnchor.isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: mainStackView.superview!.centerXAnchor).isActive = true
        
        addSubview(skillImageView)
        skillImageView.translatesAutoresizingMaskIntoConstraints = false
        skillImageViewTopAnchor = skillImageView.topAnchor.constraint(equalTo: skillImageView.superview!.safeTopAnchor, constant: 16)
        skillImageView.centerXAnchor.constraint(equalTo: skillImageView.superview!.centerXAnchor).isActive = true
        skillImageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -32).isActive = true
        skillImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        skillImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true

        mainStackView.addArrangedSubview(yourlevelLabel)
        yourlevelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonWidth = (UIScreen.main.bounds.width - 16*2 - 8*2)/3
        buttonsStackView.addArrangedSubview(firstSkillButton)
        firstSkillButton.translatesAutoresizingMaskIntoConstraints = false
        firstSkillButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        firstSkillButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buttonsStackView.addArrangedSubview(secondSkillButton)
        secondSkillButton.translatesAutoresizingMaskIntoConstraints = false
        secondSkillButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        secondSkillButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        buttonsStackView.addArrangedSubview(thirdSkillButton)
        thirdSkillButton.translatesAutoresizingMaskIntoConstraints = false
        thirdSkillButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        thirdSkillButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        mainStackView.addArrangedSubview(descriptionlabel)
        descriptionlabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(skillsStackView)
        skillsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        beginnerLabelStackView.addArrangedSubview(beginnerlabel)
        beginnerLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        beginnerlabel.translatesAutoresizingMaskIntoConstraints = false
        beginnerLabelStackView.addArrangedSubview(whistle1ImageView)
        whistle1ImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        whistle1ImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        whistle1ImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let begView = UIView()
        begView.translatesAutoresizingMaskIntoConstraints = false
        beginnerLabelStackView.addArrangedSubview(begView)
        skillsStackView.addArrangedSubview(beginnerLabelStackView)

        championLabelStackView.addArrangedSubview(championlabel)
        championLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        championlabel.translatesAutoresizingMaskIntoConstraints = false
        championLabelStackView.addArrangedSubview(whistle2ImageView)
        whistle2ImageView.translatesAutoresizingMaskIntoConstraints = false
        whistle2ImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        whistle2ImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        skillsStackView.addArrangedSubview(championLabelStackView)
        
        expertLabelStackView.addArrangedSubview(expertlabel)
        expertLabelStackView.addArrangedSubview(whistle3ImageView)
        let exView = UIView()
        exView.translatesAutoresizingMaskIntoConstraints = false
        expertLabelStackView.addArrangedSubview(exView)
        skillsStackView.addArrangedSubview(expertLabelStackView)
        expertlabel.translatesAutoresizingMaskIntoConstraints = false
        whistle3ImageView.translatesAutoresizingMaskIntoConstraints = false
        whistle3ImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        whistle3ImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        buttonsStackView.addArrangedSubview(UIView())
        
        addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.widthAnchor.constraint(equalToConstant: 248).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: continueButton.superview!.centerXAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: continueButton.superview!.bottomAnchor, constant: -32).isActive = true
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
