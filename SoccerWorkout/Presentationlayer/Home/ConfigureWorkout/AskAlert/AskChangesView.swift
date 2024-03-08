//

import UIKit

class AskChangesView: UIView {
    
    let alertBackgroundView = GradientView(cornerRadius: 24,
                                              colors: [
                                                UIColor(netHex: 0x211F1F).cgColor,
                                                UIColor(netHex: 0x1C1B1B).cgColor
                                              ])
    
    let blackBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let noButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("No", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let saveButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitle("Save Change ", for: .normal)
        btn.changeActiveStatus(isActive: true)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private let buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    private let askLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
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
        backgroundColor = .clear
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.paragraphSpacingBefore = 2
        
        let titleAttributes: [NSAttributedString.Key : Any]  = [
            .font: UIFont(font: .PoppinsMedium, size: 18),
            .foregroundColor: UIColor.white,
            .paragraphStyle: style
        ] as [NSAttributedString.Key : Any]
        
        // Subtitle
        let subtitleAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 14),
            .foregroundColor: UIColor.AppCollors.defaultGray,
            .paragraphStyle: style
        ] as [NSAttributedString.Key : Any]
        
        let titleAttributedStringComponents = [
            NSAttributedString(string: "Would you like to make changes?\n",
                                     attributes: titleAttributes),
            NSAttributedString(string: "You will apply these changes only to a specific workout and can change them at any time",
                                     attributes: subtitleAttributes)
        ] as [AttributedStringComponent]
        askLabel.attributedText = NSAttributedString(from: titleAttributedStringComponents, defaultAttributes: [:])!
        askLabel.sizeToFit()
        
        noButton.addTarget(nil, action: #selector(AskChangesViewController.noTapped), for: .touchUpInside)
        saveButton.addTarget(nil, action: #selector(AskChangesViewController.saveTapped), for: .touchUpInside)
        
        addSubview(blackBackgroundView)
        blackBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        blackBackgroundView.leftAnchor.constraint(equalTo: blackBackgroundView.superview!.leftAnchor).isActive = true
        blackBackgroundView.rightAnchor.constraint(equalTo: blackBackgroundView.superview!.rightAnchor).isActive = true
        blackBackgroundView.topAnchor.constraint(equalTo: blackBackgroundView.superview!.topAnchor).isActive = true
        blackBackgroundView.bottomAnchor.constraint(equalTo: blackBackgroundView.superview!.bottomAnchor).isActive = true
        
        addSubview(alertBackgroundView)
        alertBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        alertBackgroundView.centerXAnchor.constraint(equalTo: alertBackgroundView.superview!.centerXAnchor).isActive = true
        alertBackgroundView.centerYAnchor.constraint(equalTo: alertBackgroundView.superview!.centerYAnchor).isActive = true
        alertBackgroundView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        alertBackgroundView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        alertBackgroundView.addSubview(askLabel)
        alertBackgroundView.addSubview(buttonsStackView)
        askLabel.translatesAutoresizingMaskIntoConstraints = false
        askLabel.topAnchor.constraint(equalTo: askLabel.superview!.topAnchor, constant: 16).isActive = true
        askLabel.leftAnchor.constraint(equalTo: askLabel.superview!.leftAnchor, constant: 16).isActive = true
        askLabel.rightAnchor.constraint(equalTo: askLabel.superview!.rightAnchor, constant: -16).isActive = true
        askLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -16).isActive = true
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.bottomAnchor.constraint(equalTo: buttonsStackView.superview!.bottomAnchor, constant: -16).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: buttonsStackView.superview!.leftAnchor, constant: 16).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: buttonsStackView.superview!.rightAnchor, constant: -16).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buttonsStackView.addArrangedSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.widthAnchor.constraint(equalToConstant: 106).isActive = true
        noButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buttonsStackView.addArrangedSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.widthAnchor.constraint(equalToConstant: 212).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}
