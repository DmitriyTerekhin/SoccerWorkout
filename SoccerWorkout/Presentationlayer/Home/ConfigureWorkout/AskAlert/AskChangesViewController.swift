//

import UIKit

protocol AskChangesDelegate: AnyObject {
    func saveTapped()
    func noTapped()
}

class AskChangesViewController: UIViewController {
    
    private let contentView = AskChangesView()
    
    weak var delegate: AskChangesDelegate?
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func noTapped() {
        delegate?.noTapped()
        dismiss()
    }
    
    @objc
    func saveTapped() {
        delegate?.saveTapped()
        dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.25) {
            self.contentView.blackBackgroundView.alpha = 0.6
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.blackBackgroundView.alpha = 0
            self.dismiss(animated: true)
        }, completion: { _ in
        })
    }

}
