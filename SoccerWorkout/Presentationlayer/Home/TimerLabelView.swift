//
//  TimerLabelView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class TimerLabelView: UIView {
    
    override var bounds: CGRect {
        didSet {
            guard !bounds.isEmpty else { return }
            setGradientBackground()
        }
    }

    let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white.withAlphaComponent(0.2)
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 24)
        lbl.text = "0"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 20
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: timeLabel.superview!.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeLabel.superview!.centerYAnchor).isActive = true
    }

    func setGradientBackground() {
        let colorTop =  UIColor(netHex: 0x181717).cgColor
        let colorBottom = UIColor(netHex: 0x141414).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.2]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 12
                
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
