//
//  StatusView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class StatusView: UIView {
    
    private let whistleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "whistle")
        iv.layer.zPosition = 10
        return iv
    }()
    
    private let skillImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Beginner")
        return iv
    }()
    
    private let numberLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 16)
        lbl.layer.zPosition = 10
        lbl.text = "0"
        return lbl
    }()

    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        sv.distribution = .equalCentering
        sv.alignment = .center
        return sv
    }()
    private let backgroundView = GradientView(cornerRadius: 16,
                                              colors: [
                                                UIColor(netHex: 0x211F1F).cgColor,
                                                UIColor(netHex: 0x1C1B1B).cgColor
                                              ])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserSkill(skill: Skill, points: Int) {
        skillImageView.image = UIImage(named: skill.imageName)
        numberLabel.text = "\(points)"
    }
    
    func setupView() {
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: stackView.superview!.leftAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: stackView.superview!.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: stackView.superview!.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(whistleImageView)
        whistleImageView.translatesAutoresizingMaskIntoConstraints = false
        whistleImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        whistleImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        stackView.addArrangedSubview(numberLabel)
        stackView.setCustomSpacing(20, after: numberLabel)
        stackView.addArrangedSubview(skillImageView)
        skillImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        skillImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        stackView.insertSubview(backgroundView, belowSubview: numberLabel)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leftAnchor.constraint(equalTo: whistleImageView.leftAnchor, constant: -4).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 6).isActive = true
        backgroundView.topAnchor.constraint(equalTo: whistleImageView.topAnchor, constant: -4).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: whistleImageView.bottomAnchor, constant: 4).isActive = true
    }

}
