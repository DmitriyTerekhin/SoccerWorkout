//

import UIKit

class AllWorkoutsDoneView: UIView {

    override var bounds: CGRect {
        didSet {
            guard !bounds.isEmpty else { return }
            setGradientBackground()
        }
    }
    
    private let topTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let title = "Great job\n"
        let subtitle = "You have completed all the workouts for today"
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.paragraphSpacingBefore = 8
        let titleAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 18),
            .foregroundColor: UIColor.AppCollors.orange,
            .paragraphStyle: style
        ] as [NSAttributedString.Key : Any]
        
        // Subtitle
        let subtitleAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.defaultGray,
            .paragraphStyle: style
        ] as [NSAttributedString.Key : Any]
        
        let titleAttributedStringComponents = [
            NSAttributedString(string: title,
                                     attributes: titleAttributes),
            NSAttributedString(string: subtitle,
                                     attributes: subtitleAttributes)
        ] as [AttributedStringComponent]
        
        topTitleLabel.attributedText = NSAttributedString(from: titleAttributedStringComponents,
                                                          defaultAttributes: titleAttributes)
        
        addSubview(topTitleLabel)
        topTitleLabel.numberOfLines = 0
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        topTitleLabel.leftAnchor.constraint(equalTo: topTitleLabel.superview!.leftAnchor, constant: 16).isActive = true
        topTitleLabel.rightAnchor.constraint(equalTo: topTitleLabel.superview!.rightAnchor, constant: -16).isActive = true
        topTitleLabel.topAnchor.constraint(equalTo: topTitleLabel.superview!.topAnchor, constant: 16).isActive = true
        topTitleLabel.bottomAnchor.constraint(equalTo: topTitleLabel.superview!.bottomAnchor, constant: -16).isActive = true
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
