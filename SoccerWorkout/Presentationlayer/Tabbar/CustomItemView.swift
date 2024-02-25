//
//  CustomItemView.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 25.07.2023.
//

import UIKit

final class CustomItemView: UIView {
    
    // MARK: Public
    var viewTapped: ((Int) -> Void)?
    var viewController: UIViewController { item.viewController }
    var type: CustomTabItemType { item.type }
    let index: Int
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    // MARK: - Privates
    private let buttonOver = UIButton()
    private let titleLabel = UILabel()
    private let iconBackgroundView = UIView()
    private let iconImageView = UIImageView()
    private let containerView = UIView()
    private let item: CustomTabItem

    init(with item: CustomTabItem, index: Int) {
        self.item = item
        self.index = index
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(iconBackgroundView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(buttonOver)
    }
    
    private func setupLayout() {
        containerView.topAnchor.constraint(equalTo: containerView.superview!.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: containerView.superview!.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: containerView.superview!.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: containerView.superview!.bottomAnchor).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconBackgroundView.centerXAnchor.constraint(equalTo: iconBackgroundView.superview!.centerXAnchor).isActive = true
        iconBackgroundView.centerYAnchor.constraint(equalTo: iconBackgroundView.superview!.centerYAnchor).isActive = true
        iconBackgroundView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iconBackgroundView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iconBackgroundView.layer.cornerRadius = 24
        
        iconImageView.centerXAnchor.constraint(equalTo: iconImageView.superview!.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconImageView.superview!.centerYAnchor, constant: -5).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: CGFloat(17).dp).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: CGFloat(17).dp).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: titleLabel.superview!.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.setFont(fontName: .PoppinsRegular, sizeXS: 12)
        
        buttonOver.topAnchor.constraint(equalTo: buttonOver.superview!.topAnchor).isActive = true
        buttonOver.leftAnchor.constraint(equalTo: buttonOver.superview!.leftAnchor).isActive = true
        buttonOver.rightAnchor.constraint(equalTo: buttonOver.superview!.rightAnchor).isActive = true
        buttonOver.bottomAnchor.constraint(equalTo: buttonOver.superview!.bottomAnchor).isActive = true
        buttonOver.translatesAutoresizingMaskIntoConstraints = false
        buttonOver.addTarget(self, action: #selector(tabTapped), for: .touchUpInside)
     }
    
    private func setupProperties() {
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        titleLabel.text = item.type.title
    }
    
    private func animateItems() {
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        titleLabel.textColor = isSelected ? .AppCollors.orange : UIColor(red: 109, green: 108, blue: 106)
    }
    
    @objc
    private func tabTapped() {
        viewTapped?(index)
    }
}
