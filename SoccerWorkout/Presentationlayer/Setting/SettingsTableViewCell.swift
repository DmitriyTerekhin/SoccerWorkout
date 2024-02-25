//
//  SettingsTableViewCell.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    private let titlelabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return lbl
    }()
    
    private let iconImageView = UIImageView()
    private var labelTopAnchor = NSLayoutConstraint()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(type: SettingsTypes) {
        titlelabel.text = type.title
        iconImageView.image = UIImage(named: type.logoImageString)
        
        guard case .delete = type else {
            return
        }
        titlelabel.textColor = .AppCollors.defaultGray
        labelTopAnchor.constant = 40
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubview(titlelabel)
        contentView.addSubview(iconImageView)
        
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.centerYAnchor.constraint(equalTo: titlelabel.superview!.centerYAnchor).isActive = true
        titlelabel.leftAnchor.constraint(equalTo: titlelabel.superview!.leftAnchor, constant: 16).isActive = true
        titlelabel.rightAnchor.constraint(lessThanOrEqualTo: iconImageView.leftAnchor, constant: -16).isActive = true
        labelTopAnchor = titlelabel.topAnchor.constraint(equalTo: titlelabel.superview!.topAnchor, constant: 16)
        labelTopAnchor.isActive = true
        titlelabel.bottomAnchor.constraint(equalTo: titlelabel.superview!.bottomAnchor, constant: -8).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: titlelabel.centerYAnchor).isActive = true
        iconImageView.rightAnchor.constraint(equalTo: iconImageView.superview!.rightAnchor, constant: -16).isActive = true
    }
}
