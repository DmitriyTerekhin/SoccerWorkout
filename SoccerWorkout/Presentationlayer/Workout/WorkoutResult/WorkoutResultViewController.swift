//

import UIKit

class WorkoutResultViewController: UIViewController {
    
    private let contentView = WorkoutResultView()
    private let workoutResultModels: [FinishedResultstTypes]
    
    init(workoutResultModels: [FinishedResultstTypes]) {
        self.workoutResultModels = workoutResultModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.finishedView.configureView(info: workoutResultModels)
    }
    
    @objc
    func closeTapped() {
        dismiss(animated: true)
    }
}
