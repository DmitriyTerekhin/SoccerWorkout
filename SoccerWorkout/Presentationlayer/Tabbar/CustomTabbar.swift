//
//  CustomTabbar.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 25.07.2023.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func itemWasTapped(with index: Int)
}

final class CustomTabBar: UIStackView {
    
    // MARK: - Public properties
    var itemTapped: Int = 0
    var allViewControllers: [UIViewController] {
        customItemViews.map(\.viewController)
    }
    weak var delegate: CustomTabBarDelegate?
    
    // MARK: - Private Properties
    private lazy var customItemViews: [CustomItemView] = [
        workout,
        history,
        profile
    ]
    private lazy var workout = CustomItemView(with: CustomTabItem(type: .Home,
                                                                  viewController: presentationAssembly.homeScreen()
                                                                  ),
                                               index: 0)
    private lazy var history = CustomItemView(with: CustomTabItem(type: .History,
                                                                  viewController: presentationAssembly.workoutScreen()),
                                              index: 1)
    private lazy var profile = CustomItemView(with: CustomTabItem(type: .Settings,
                                                                  viewController: presentationAssembly.settingsScreen()
                                                                   ),
                                                        index: 2)

    private let presentationAssembly: IPresentationAssembly
    
    init(presentationAssembly: IPresentationAssembly) {
        self.presentationAssembly = presentationAssembly
        super.init(frame: .zero)
        setupHierarchy()
        setupProperties()
        setNeedsLayout()
        layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addArrangedSubview(workout)
        addArrangedSubview(history)
        addArrangedSubview(profile)
    }
    
    private func setupProperties() {
        backgroundColor = UIColor.clear
        addBackground(color: UIColor.clear, cornerRadius: 0)
        distribution = .fillEqually
        alignment = .center
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
            $0.viewTapped = selectItem
        }
    }
    
    func getIndexFor(type: CustomTabItemType) -> Int? {
        customItemViews.first { $0.type == type }?.index
    }
    
    func getType(byIndex: Int) -> CustomTabItemType {
        return customItemViews[byIndex].type
    }
    
    func getViewController(byIndex: Int) -> UIViewController {
        allViewControllers[byIndex]
    }
    
    func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        delegate?.itemWasTapped(with: index)
    }
}

private extension UIStackView {
    func addBackground(color: UIColor, cornerRadius: CGFloat = 0) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.layer.cornerRadius = cornerRadius
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }
}
