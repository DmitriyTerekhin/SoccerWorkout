//

import UIKit

class HistoryTableViewCell: WorkoutTableViewCell {

    private let pointsLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .AppCollors.defaultGray
        lbl.text = "0"
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 14)
        return lbl
    }()
    
    private let whistleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "whistle")
        iv.layer.zPosition = 10
        return iv
    }()
    
    private var pointsRightLabelToImage = NSLayoutConstraint()
    private var pointsRightLabelToSuperView = NSLayoutConstraint()

    override func setupView() {
        super.setupView()
        editButton.isHidden = true
        
        contentBackgroundView.addSubview(whistleImageView)
        whistleImageView.translatesAutoresizingMaskIntoConstraints = false
        whistleImageView.centerYAnchor.constraint(equalTo: whistleImageView.superview!.centerYAnchor).isActive = true
        whistleImageView.rightAnchor.constraint(equalTo: whistleImageView.superview!.rightAnchor, constant: -16).isActive = true
        whistleImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        whistleImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentBackgroundView.addSubview(pointsLabel)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.centerYAnchor.constraint(equalTo: pointsLabel.superview!.centerYAnchor).isActive = true
        pointsRightLabelToImage = pointsLabel.rightAnchor.constraint(equalTo: whistleImageView.leftAnchor, constant: -4)
        pointsRightLabelToImage.isActive = true
        pointsRightLabelToSuperView = pointsLabel.rightAnchor.constraint(equalTo: pointsLabel.superview!.rightAnchor, constant: -16)
    }
    
    func configureView(model: WorkoutHistoryViewModel) {
        id = model.id
        topTitleLabel.attributedText = model.title
        bottomDescriptionLabel.attributedText = model.subtitle
        pointsLabel.text = model.points
        pointsRightLabelToSuperView.isActive = model.wasPassed ? false : true
        pointsRightLabelToImage.isActive = model.wasPassed ? true : false
        whistleImageView.isHidden = !model.wasPassed
    }

}
