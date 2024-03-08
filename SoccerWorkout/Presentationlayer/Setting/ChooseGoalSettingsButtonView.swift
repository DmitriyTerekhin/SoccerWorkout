//

import UIKit

class ChooseGoalSettingsButtonView: UIView {
    
    let contentBackgroundView: GradientView = {
        let view = GradientView(cornerRadius: 20,
                                colors: [
                                  UIColor(netHex: 0x211F1F).cgColor,
                                  UIColor(netHex: 0x1C1B1B).cgColor
                                ])
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.spacing = 4
        return sv
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.minimumScaleFactor = 0.5
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.AppCollors.defaultGray, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsRegular, sizeXS: 14)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(level: Skill?) {
        if let level = level {
            let defaultAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.white
            ] as [NSAttributedString.Key : Any]
            let lowAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.orange
            ] as [NSAttributedString.Key : Any]

            let attributedStringComponents = [
                NSAttributedString(string: "Your goal ",
                                         attributes: defaultAttributes),
                NSAttributedString(string: level.rawValue.capitalized,
                                         attributes: lowAttributes)
            ] as [AttributedStringComponent]
            titleLabel.attributedText = NSAttributedString(from: attributedStringComponents,
                                                           defaultAttributes: [:])
            editButton.setTitle("Edit", for: .normal)
        } else {
            titleLabel.setFont(fontName: .PoppinsMedium, sizeXS: 14)
            titleLabel.text = "Do you want to increase your level?"
            titleLabel.textColor = .white
            editButton.setTitle("Go", for: .normal)
        }
    }
    
    private func setupView() {
        addSubview(contentBackgroundView)
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.leftAnchor.constraint(equalTo: contentBackgroundView.superview!.leftAnchor, constant: 0).isActive = true
        contentBackgroundView.topAnchor.constraint(equalTo: contentBackgroundView.superview!.topAnchor, constant: 0).isActive = true
        contentBackgroundView.rightAnchor.constraint(equalTo: contentBackgroundView.superview!.rightAnchor, constant: 0).isActive = true
        contentBackgroundView.bottomAnchor.constraint(equalTo: contentBackgroundView.superview!.bottomAnchor, constant: 0).isActive = true
        
        contentBackgroundView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: stackView.superview!.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: stackView.superview!.rightAnchor, constant: -28).isActive = true
        stackView.centerYAnchor.constraint(equalTo: stackView.superview!.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        stackView.addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
