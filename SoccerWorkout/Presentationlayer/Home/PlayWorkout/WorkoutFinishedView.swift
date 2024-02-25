//
//  WorkoutFinishedView.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import UIKit

class WorkoutFinishedView: UIView {
    
    private enum Constants {
        static let title = "Great training session over\n"
        static let subtitle = "keep up the good work"
    }
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 16)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 3
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(info: [FinishedResultstTypes]) {
        setupView(infoCount: CGFloat(info.count))
        info.forEach { type in
            let listIem = WorkoutFinishedListItemView()
            listIem.configureView(title: type.title, detailInfo: type.value)
            listIem.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(listIem)
        }
    }
    
    private func setupView(infoCount: CGFloat) {
        backgroundColor = .AppCollors.background
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let height: CGFloat = 60 + 32 + infoCount*40
        stackView.widthAnchor.constraint(equalToConstant: 358).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        stackView.centerXAnchor.constraint(equalTo: stackView.superview!.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: stackView.superview!.centerYAnchor).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(32, after: titleLabel)
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.paragraphSpacingBefore = 8
        let defaultAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 18),
            .foregroundColor: UIColor.white,
            .paragraphStyle: style
        ] as [NSAttributedString.Key : Any]

        let style2 = NSMutableParagraphStyle()
        style2.alignment = NSTextAlignment.center
        style2.paragraphSpacingBefore = 8
        let lowAttributes = [
            .font: UIFont(font: .PoppinsMedium, size: 17),
            .foregroundColor: UIColor.AppCollors.defaultGray,
            .paragraphStyle: style2
        ] as [NSAttributedString.Key : Any]

        let attributedStringComponents = [
            NSAttributedString(string: Constants.title,
                                     attributes: defaultAttributes),
            NSAttributedString(string: Constants.subtitle,
                                     attributes: lowAttributes)
        ] as [AttributedStringComponent]
        titleLabel.attributedText = NSMutableAttributedString(from: attributedStringComponents, defaultAttributes: defaultAttributes)
    }
    
}
