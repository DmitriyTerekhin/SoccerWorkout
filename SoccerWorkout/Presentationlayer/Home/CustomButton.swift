//
//  CustomButton.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class CustomButton: LoaderButton {
    
    private let gradientLayer = CAGradientLayer()
    private var isActive: Bool = false
    private var isButtonEnable: Bool = true
    private let inActiveColors = [
        UIColor(netHex: 0x141414).cgColor,
        UIColor(netHex: 0x181717).cgColor
    ]
    private let activeColors = [
        UIColor(netHex: 0xEA6944).cgColor,
        UIColor(netHex: 0xFA5827).cgColor
    ]

    override var bounds: CGRect {
        didSet {
            guard !bounds.isEmpty else { return }
            setGradientBackground()
        }
    }
    
    func changeGradientButtonState(isActive: Bool) {
        isUserInteractionEnabled = isActive
        isButtonEnable = isActive
        if isActive {
            changeActiveStatus(isActive: isActive)
        } else {
            backgroundColor = .clear
            gradientLayer.colors = activeColors.map({ UIColor(cgColor: $0).withAlphaComponent(0.2).cgColor})
        }
    }
    
    func changeActiveStatus(isActive: Bool) {
        self.isActive = isActive
        if isActive {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradientLayer.colors = isActive ? activeColors : inActiveColors
    }

    // Для не активной кнопки нужен другой локейшн
    func setGradientBackground() {
        gradientLayer.removeFromSuperlayer()
        var colors = isActive ? activeColors : inActiveColors
        if !isButtonEnable {
            colors = colors.map({ UIColor(cgColor: $0).withAlphaComponent(0.2).cgColor})
            backgroundColor = .clear
        }
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.5]
        if isActive {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 12
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
