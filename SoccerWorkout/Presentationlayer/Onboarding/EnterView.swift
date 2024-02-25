//
//  EnterView.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 29.07.2023.
//

import UIKit

class EnterView: UIView {
    
    enum Constants {
        static let activeIndicatorWidth: Double = 20
        static let defaultIndicatorWidth: Double = 10
        static let defaultIndicatorHeight: Double = 10
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.register(EnterCollectionViewCell.self, forCellWithReuseIdentifier: EnterCollectionViewCell.reuseID)
        view.backgroundColor = UIColor.AppCollors.lightBlack
        view.isScrollEnabled = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateIndicator(step: Int) {
        
    }
    
    private func setupView() {
        backgroundColor = UIColor.AppCollors.lightBlack
        addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: collectionView.superview!.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: collectionView.superview!.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: collectionView.superview!.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionView.superview!.bottomAnchor).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}
