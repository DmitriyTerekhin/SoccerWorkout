//
//  WorkoutExerciseTableViewCell.swift
//  SoccerWorkout
//
//  Created by Ju on 23.02.2024.
//

import UIKit

class WorkoutExerciseTableViewCell: UITableViewCell {
    
    private let leftSelectorView: UIView = {
        let view = UIView()
        view.backgroundColor = .AppCollors.orange
        view.isHidden = true
        return view
    }()
    
    private let selectorBackgroundView: UIView = {
        let view = GradientView(cornerRadius: 0, colors: [
            UIColor(netHex: 0xEA6944).cgColor,
            UIColor(netHex: 0xFA5827).cgColor
        ])
        view.isHidden = true
        view.alpha = 0.2
        return view
    }()
    
    private let exerciseLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let approachLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    private let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    private let repetitionsLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    private let totalTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        lbl.textColor = .white
        return lbl
    }()

    private let infoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .equalCentering
        return sv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .AppCollors.defaultGray.withAlphaComponent(0.2)
        return view
    }()
    
    private var infoStackViewRightanchor = NSLayoutConstraint()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        exerciseLabel.textColor = .white
        approachLabel.textColor = .white
        timeLabel.textColor = .white
        repetitionsLabel.textColor = .white
        totalTimeLabel.textColor = .white
        infoStackViewRightanchor.constant = -22
    }
    
    func configureView(model: ExerciseModel) {
        exerciseLabel.text = model.excercise
        approachLabel.text = model.approach
        timeLabel.text = model.time
        repetitionsLabel.text = model.repetition
        totalTimeLabel.text = model.totalTime
        leftSelectorView.isHidden = !model.isActiveNow
        selectorBackgroundView.isHidden = !model.isActiveNow
        guard model == ExerciseModel.empty else { return }
        exerciseLabel.textColor = .AppCollors.defaultGray
        approachLabel.textColor = .AppCollors.defaultGray
        timeLabel.textColor = .AppCollors.defaultGray
        repetitionsLabel.textColor = .AppCollors.defaultGray
        totalTimeLabel.textColor = .AppCollors.defaultGray
        infoStackViewRightanchor.constant = -32
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(exerciseLabel)
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseLabel.topAnchor.constraint(equalTo: exerciseLabel.superview!.topAnchor, constant: 8).isActive = true
        exerciseLabel.bottomAnchor.constraint(equalTo: exerciseLabel.superview!.bottomAnchor, constant: -8).isActive = true
        exerciseLabel.leftAnchor.constraint(equalTo: exerciseLabel.superview!.leftAnchor, constant: 24).isActive = true
        exerciseLabel.rightAnchor.constraint(equalTo: exerciseLabel.superview!.centerXAnchor, constant: -5).isActive = true
        
        contentView.addSubview(infoStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        infoStackView.centerYAnchor.constraint(equalTo: exerciseLabel.centerYAnchor).isActive = true
        infoStackView.leftAnchor.constraint(equalTo: infoStackView.superview!.centerXAnchor).isActive = true
        infoStackViewRightanchor = infoStackView.rightAnchor.constraint(equalTo: infoStackView.superview!.rightAnchor, constant: -22)
        infoStackViewRightanchor.isActive = true
        infoStackView.addArrangedSubview(approachLabel)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(repetitionsLabel)
        repetitionsLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(totalTimeLabel)
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leftAnchor.constraint(equalTo: separatorView.superview!.leftAnchor, constant: 16).isActive = true
        separatorView.rightAnchor.constraint(equalTo: separatorView.superview!.rightAnchor, constant:  -16).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: separatorView.superview!.bottomAnchor).isActive = true
        
        contentView.addSubview(leftSelectorView)
        leftSelectorView.translatesAutoresizingMaskIntoConstraints = false
        leftSelectorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        leftSelectorView.topAnchor.constraint(equalTo: leftSelectorView.superview!.topAnchor).isActive = true
        leftSelectorView.bottomAnchor.constraint(equalTo: leftSelectorView.superview!.bottomAnchor, constant: -4).isActive = true
        leftSelectorView.leftAnchor.constraint(equalTo: leftSelectorView.superview!.leftAnchor, constant: 16).isActive = true
        
        contentView.insertSubview(selectorBackgroundView, belowSubview: exerciseLabel)
        selectorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectorBackgroundView.leftAnchor.constraint(equalTo: leftSelectorView.rightAnchor).isActive = true
        selectorBackgroundView.topAnchor.constraint(equalTo: leftSelectorView.topAnchor).isActive = true
        selectorBackgroundView.bottomAnchor.constraint(equalTo: leftSelectorView.bottomAnchor).isActive = true
        selectorBackgroundView.rightAnchor.constraint(equalTo: selectorBackgroundView.superview!.rightAnchor, constant: -16).isActive = true
    }
}
