//
//  TimerView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class TimerView: UIView {

    private let stackView = UIStackView()
    private let hLabelView = TimerLabelView()
    private let hhLabelView = TimerLabelView()
    private let mLabelView = TimerLabelView()
    private let mmLabelView = TimerLabelView()
    
    private let dividerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ":"
        lbl.textColor = .white
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 24)
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTimer() {
        
    }
    
    func changeNumbersColor(_ color: UIColor) {
        hLabelView.timeLabel.textColor = color
        hhLabelView.timeLabel.textColor = color
        mLabelView.timeLabel.textColor = color
        mmLabelView.timeLabel.textColor = color
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.leftAnchor.constraint(equalTo: stackView.superview!.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: stackView.superview!.rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: stackView.superview!.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 208).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        stackView.addArrangedSubview(hLabelView)
        hLabelView.widthAnchor.constraint(equalToConstant: 47).isActive = true
        hLabelView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        hLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(hhLabelView)
        hhLabelView.widthAnchor.constraint(equalToConstant: 47).isActive = true
        hhLabelView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        hhLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(dividerLabel)
        dividerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(mLabelView)
        mLabelView.widthAnchor.constraint(equalToConstant: 47).isActive = true
        mLabelView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        mLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(mmLabelView)
        mmLabelView.widthAnchor.constraint(equalToConstant: 47).isActive = true
        mmLabelView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        mmLabelView.translatesAutoresizingMaskIntoConstraints = false
    }
}
