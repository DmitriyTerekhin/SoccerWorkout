//
//  PlayWorkoutBottomView.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import UIKit

class PlayWorkoutBottomView: GradientView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let completeButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("Complete the exercise", for: .normal)
        btn.changeActiveStatus(isActive: true)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return btn
    }()
    
    let numberLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        lbl.text = "# 1"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var stackViewConstraint = NSLayoutConstraint()
    
    override init(cornerRadius: CGFloat, colors: [CGColor]) {
        super.init(cornerRadius: cornerRadius, colors: colors)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeStackViewWidth(_ to: CGFloat) {
        stackViewConstraint.constant = to
        stackView.superview!.layoutIfNeeded()
    }
    
    func setupView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewConstraint = stackView.widthAnchor.constraint(equalToConstant: 338)
        stackViewConstraint.isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        stackView.centerXAnchor.constraint(equalTo: stackView.superview!.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: stackView.superview!.centerYAnchor).isActive = true
        
        stackView.addArrangedSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(completeButton)
        completeButton.widthAnchor.constraint(equalToConstant: 248).isActive = true
        completeButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
