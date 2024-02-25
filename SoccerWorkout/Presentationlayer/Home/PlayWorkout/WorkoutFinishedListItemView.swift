//
//  WorkoutFinishedListItemView.swift
//  SoccerWorkout
//
//  Created by Ju on 24.02.2024.
//

import UIKit

class WorkoutFinishedListItemView: UIView {
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .AppCollors.defaultGray.withAlphaComponent(0.2)
        return view
    }()
    
    let itemNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()

    let numbersLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        lbl.textAlignment = .right
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(title: NSAttributedString, detailInfo: NSAttributedString?) {
        self.itemNameLabel.attributedText = title
        self.numbersLabel.attributedText = detailInfo
    }
    
    private func setupView() {
        addSubview(itemNameLabel)
        addSubview(numbersLabel)
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leftAnchor.constraint(equalTo: separatorView.superview!.leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: separatorView.superview!.rightAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.topAnchor.constraint(equalTo: separatorView.superview!.topAnchor).isActive = true
        
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.leftAnchor.constraint(equalTo: itemNameLabel.superview!.leftAnchor, constant: 8).isActive = true
        itemNameLabel.rightAnchor.constraint(equalTo: numbersLabel.leftAnchor, constant: -16).isActive = true
        itemNameLabel.topAnchor.constraint(equalTo: itemNameLabel.superview!.topAnchor, constant: 8).isActive = true
        itemNameLabel.bottomAnchor.constraint(equalTo: itemNameLabel.superview!.bottomAnchor, constant: -8).isActive = true
//        itemNameLabel.centerYAnchor.constraint(equalTo: itemNameLabel.superview!.centerYAnchor).isActive = true
        
        numbersLabel.translatesAutoresizingMaskIntoConstraints = false
        numbersLabel.rightAnchor.constraint(equalTo: numbersLabel.superview!.rightAnchor, constant: -16).isActive = true
        numbersLabel.centerYAnchor.constraint(equalTo: numbersLabel.superview!.centerYAnchor).isActive = true
    }

}
