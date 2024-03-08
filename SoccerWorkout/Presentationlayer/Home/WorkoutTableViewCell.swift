//
//  WorkoutTableViewCell.swift
//  SoccerWorkout
//
//  Created by Ju on 22.02.2024.
//

import UIKit

protocol WorkoutTableViewCellDelegate: AnyObject {
    func editButtonTapped(id: Int)
}

class WorkoutTableViewCell: UITableViewCell {
   
    let contentBackgroundView: GradientView = {
        let view = GradientView(cornerRadius: 20,
                                colors: [
                                  UIColor(netHex: 0x211F1F).cgColor,
                                  UIColor(netHex: 0x1C1B1B).cgColor
                                ])
        view.layer.cornerRadius = 20
        return view
    }()
    private let mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 4
        return sv
    }()
    private let bottomStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.distribution = .equalCentering
        sv.spacing = 6
        return sv
    }()
    private let circleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "GrayCircle")
        return iv
    }()
    let topTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.minimumScaleFactor = 0.5
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    let bottomDescriptionLabel = UILabel()
    let editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(.AppCollors.defaultGray, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsRegular, sizeXS: 14)
        return btn
    }()
    var id: Int?
    weak var delegate: WorkoutTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(model: HomeViewModel) {
        id = model.id
        topTitleLabel.attributedText = model.title
        bottomDescriptionLabel.attributedText = model.subtitle
    }
    
    @objc
    func editButtonTapped() {
        guard let id = id else { return }
        delegate?.editButtonTapped(id: id)
    }
    
    func setupView() {
        backgroundColor = .clear
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(contentBackgroundView)
        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentBackgroundView.leftAnchor.constraint(equalTo: contentBackgroundView.superview!.leftAnchor, constant: 16).isActive = true
        contentBackgroundView.topAnchor.constraint(equalTo: contentBackgroundView.superview!.topAnchor, constant: 16).isActive = true
        contentBackgroundView.bottomAnchor.constraint(equalTo: contentBackgroundView.superview!.bottomAnchor, constant: 0).isActive = true
        contentBackgroundView.rightAnchor.constraint(equalTo: contentBackgroundView.superview!.rightAnchor, constant: -16).isActive = true
        
        mainStackView.addArrangedSubview(topTitleLabel)
        topTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(circleImageView)
        imageContainer.widthAnchor.constraint(equalToConstant: 8).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 20).isActive = true
        circleImageView.centerYAnchor.constraint(equalTo: circleImageView.superview!.centerYAnchor).isActive = true
        circleImageView.centerXAnchor.constraint(equalTo: circleImageView.superview!.centerXAnchor).isActive = true
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(imageContainer)
        bottomStackView.addArrangedSubview(bottomDescriptionLabel)
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentBackgroundView.addSubview(mainStackView)
        contentBackgroundView.addSubview(editButton)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leftAnchor.constraint(equalTo: mainStackView.superview!.leftAnchor, constant: 16).isActive = true
        mainStackView.topAnchor.constraint(equalTo: mainStackView.superview!.topAnchor, constant: 16).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainStackView.superview!.bottomAnchor, constant: -16).isActive = true
        mainStackView.rightAnchor.constraint(lessThanOrEqualTo: editButton.leftAnchor, constant: -16).isActive = true
        
        editButton.centerYAnchor.constraint(equalTo: editButton.superview!.centerYAnchor).isActive = true
        editButton.rightAnchor.constraint(equalTo: editButton.superview!.rightAnchor, constant: -16).isActive = true
        editButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
