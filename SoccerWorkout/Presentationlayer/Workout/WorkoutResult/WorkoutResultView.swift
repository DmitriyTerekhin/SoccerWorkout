//

import UIKit

class WorkoutResultView: UIView {
    
    let finishedView = WorkoutFinishedView()
    let botttomView = PlayWorkoutBottomView(cornerRadius: 16,
                                                    colors: [
                                                        UIColor(netHex: 0x211F1F).cgColor,
                                                        UIColor(netHex: 0x1C1B1B).cgColor
                                                    ])

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(finishedView)
        finishedView.translatesAutoresizingMaskIntoConstraints = false
        finishedView.topAnchor.constraint(equalTo: finishedView.superview!.topAnchor).isActive = true
        finishedView.leftAnchor.constraint(equalTo: finishedView.superview!.leftAnchor).isActive = true
        finishedView.rightAnchor.constraint(equalTo: finishedView.superview!.rightAnchor).isActive = true
        finishedView.bottomAnchor.constraint(equalTo: finishedView.superview!.bottomAnchor).isActive = true
        
        addSubview(botttomView)
        botttomView.translatesAutoresizingMaskIntoConstraints = false
        botttomView.leftAnchor.constraint(equalTo: botttomView.superview!.leftAnchor).isActive = true
        botttomView.rightAnchor.constraint(equalTo: botttomView.superview!.rightAnchor).isActive = true
        botttomView.bottomAnchor.constraint(equalTo: botttomView.superview!.bottomAnchor).isActive = true
        botttomView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        
        botttomView.changeStackViewWidth(248)
        botttomView.numberLabel.isHidden = true
        botttomView.completeButton.setTitle("Close", for: .normal)
        botttomView.completeButton.addTarget(nil,
                                             action: #selector(WorkoutResultViewController.closeTapped),
                                             for: .touchUpInside)
    }
}
