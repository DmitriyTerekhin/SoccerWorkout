//
//  WorkoutSectionHeaderView.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class WorkoutSectionHeaderView: UITableViewHeaderFooterView {

    private let labelText: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 18)
        lbl.textColor = UIColor.AppCollors.defaultGray
        return lbl
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .AppCollors.background
        contentView.addSubview(labelText)
        labelText.topAnchor.constraint(equalTo: labelText.superview!.topAnchor, constant: 4).isActive = true
        labelText.bottomAnchor.constraint(equalTo: labelText.superview!.bottomAnchor, constant: -4).isActive = true
        labelText.leftAnchor.constraint(equalTo: labelText.superview!.leftAnchor, constant: 18).isActive = true
        labelText.centerYAnchor.constraint(equalTo: labelText.superview!.centerYAnchor).isActive = true
        labelText.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeader(date: Date) {
        labelText.text = date.toString("dd MMM YYYY")
    }
    
}
