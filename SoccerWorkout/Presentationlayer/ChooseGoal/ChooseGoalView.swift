//

import UIKit

class ChooseGoalView: ChooseSkillView {
    
    static let goalTimes = GoalTime.allCases
    
    private enum Constants {
        static let goalLevel = "What level do you want to reach?"
        static let timeQuestion = "How long do you want to level up?"
        static let dontWantGoal = "I don't want to level up"
    }
    
    let timeGoalLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 18)
        lbl.textColor = .AppCollors.defaultGray
        lbl.text = Constants.timeQuestion
        return lbl
    }()
    
    private let calendarButtonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let firstTimeGoalButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(ChooseGoalView.goalTimes[0].title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return btn
    }()
    
    let secondTimeGoalButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(ChooseGoalView.goalTimes[1].title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    let thirdTimeGoalButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle(ChooseGoalView.goalTimes[2].title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return btn
    }()
    
    let dontWantButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(Constants.dontWantGoal, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return btn
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()
        yourlevelLabel.text = Constants.goalLevel
        descriptionlabel.isHidden = true
        skillsStackView.isHidden = true
        statusView.isHidden = true
        
        mainStackView.addArrangedSubview(timeGoalLabel)
        timeGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(calendarButtonsStackView)
        calendarButtonsStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        calendarButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonWidth = (UIScreen.main.bounds.width - 16*2 - 8*2)/3
        calendarButtonsStackView.addArrangedSubview(firstTimeGoalButton)
        firstTimeGoalButton.translatesAutoresizingMaskIntoConstraints = false
        firstTimeGoalButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        firstTimeGoalButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        calendarButtonsStackView.addArrangedSubview(secondTimeGoalButton)
        secondTimeGoalButton.translatesAutoresizingMaskIntoConstraints = false
        secondTimeGoalButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        secondTimeGoalButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        calendarButtonsStackView.addArrangedSubview(thirdTimeGoalButton)
        thirdTimeGoalButton.translatesAutoresizingMaskIntoConstraints = false
        thirdTimeGoalButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        thirdTimeGoalButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addSubview(dontWantButton)
        dontWantButton.translatesAutoresizingMaskIntoConstraints = false
        dontWantButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        dontWantButton.centerXAnchor.constraint(equalTo: dontWantButton.superview!.centerXAnchor).isActive = true
        dontWantButton.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10).isActive = true
        
        firstSkillButton.setTitle(Skill.champion.title.capitalized, for: .normal)
        secondSkillButton.setTitle(Skill.expert.title.capitalized, for: .normal)
        thirdSkillButton.setTitle(Skill.expertPlus.title.capitalized, for: .normal)
    }
    
    func configureView(viewState: ChooseGoalViewState) {
        switch viewState {
        case .setup(let authDTO):
            skillImageView.image = UIImage(named: Skill(level: authDTO.level)?.imageName ?? "")
        case .edit(let level, let goal, let time):
            if let goalUn = goal, let timeUn = time {
                timeTapped(time: timeUn)
                skillTapped(skill: goalUn)
            }
            continueButton.setTitle("Save Goal", for: .normal)
            skillImageView.image = UIImage(named: level.imageName)
        }
    }
    
    override func skillTapped(skill: Skill, points: Int = 0) {
        statusView.setupUserSkill(skill: skill, points: points)
        switch skill {
        case .champion:
            firstSkillButton.changeActiveStatus(isActive: true)
            secondSkillButton.changeActiveStatus(isActive: false)
            thirdSkillButton.changeActiveStatus(isActive: false)
        case .expert:
            firstSkillButton.changeActiveStatus(isActive: false)
            secondSkillButton.changeActiveStatus(isActive: true)
            thirdSkillButton.changeActiveStatus(isActive: false)
        case .expertPlus:
            firstSkillButton.changeActiveStatus(isActive: false)
            secondSkillButton.changeActiveStatus(isActive: false)
            thirdSkillButton.changeActiveStatus(isActive: true)
        default:
            break
        }
    }
    
    func timeTapped(time: GoalTime) {
        switch time {
        case .twoMonth:
            firstTimeGoalButton.changeActiveStatus(isActive: true)
            secondTimeGoalButton.changeActiveStatus(isActive: false)
            thirdTimeGoalButton.changeActiveStatus(isActive: false)
        case .fourMonth:
            firstTimeGoalButton.changeActiveStatus(isActive: false)
            secondTimeGoalButton.changeActiveStatus(isActive: true)
            thirdTimeGoalButton.changeActiveStatus(isActive: false)
        case .sixMonth:
            firstTimeGoalButton.changeActiveStatus(isActive: false)
            secondTimeGoalButton.changeActiveStatus(isActive: false)
            thirdTimeGoalButton.changeActiveStatus(isActive: true)
        }
    }
    
    override func setupDelegates() {
        firstSkillButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.firstSkillButtonTapped), for: .touchUpInside)
        secondSkillButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.secondSkillButtonTapped), for: .touchUpInside)
        thirdSkillButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.thirdSkillButtonTapped), for: .touchUpInside)
        firstTimeGoalButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.firstTimeGoalButtonTapped), for: .touchUpInside)
        secondTimeGoalButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.secondTimeGoalButtonTapped), for: .touchUpInside)
        thirdTimeGoalButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.thirdTimeGoalButtonTapped), for: .touchUpInside)
        dontWantButton.addTarget(nil,
                                 action: #selector(ChooseGoalLevelViewController.dontWantTapped),
                                 for: .touchUpInside)
        continueButton.addTarget(nil, action: #selector(ChooseGoalLevelViewController.continueTapped), for: .touchUpInside)
    }
    
}
