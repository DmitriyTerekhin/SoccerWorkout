//
//  GradientView.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

class GradientView: UIView {

    override var bounds: CGRect {
        didSet {
            guard !bounds.isEmpty else { return }
            setGradientBackground()
        }
    }
    private let cornerRadius: CGFloat
    private let colors: [CGColor]
    
    init(cornerRadius: CGFloat, colors: [CGColor]) {
        self.cornerRadius = cornerRadius
        self.colors = colors
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.3]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.cornerRadius
                
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
