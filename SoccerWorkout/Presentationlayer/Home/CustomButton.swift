//
//  CustomButton.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class CustomButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    private var isActive: Bool = false
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
        gradientLayer.colors = isActive ? activeColors : inActiveColors
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
