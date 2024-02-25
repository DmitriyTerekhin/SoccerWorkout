//
//  ChooseSkillViewController.swift
//  SoccerWorkout
//
//  Created by Ju on 21.02.2024.
//

import UIKit

class ChooseSkillViewController: UIViewController {
    
    private let contentView = ChooseSkillView()
    private let presentationAssembly: IPresentationAssembly
    
    init(presentationAssembly: IPresentationAssembly) {
        self.presentationAssembly = presentationAssembly
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
    }

    @objc
    func beginnerTapped() {
        contentView.skillTapped(skill: .beginner)
    }
    
    @objc
    func championTapped() {
        contentView.skillTapped(skill: .champion)
    }
    
    @objc
    func expertTapped() {
        contentView.skillTapped(skill: .expert)
    }
    
    @objc
    func continueTapped() {
        presentationAssembly.changeRootViewController(on: presentationAssembly.tabBarViewController())
    }
}
