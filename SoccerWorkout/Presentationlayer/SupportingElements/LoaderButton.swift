//
//  LoaderButton.swift
//  FootballManager
//
//  Created by Дмитрий Терехин on 09.05.2023.
//

import UIKit
//import NVActivityIndicatorView

class LoaderButton: UIButton {
    
//    private let loaderView: NVActivityIndicatorView = {
//        let v = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: CGFloat(30).dp, height: CGFloat(30).dp),
//                                        type: NVActivityIndicatorType.circleStrokeSpin)
//        v.color = UIColor.white
//        v.layer.zPosition = 100
//        return v
//    }()
    private var wasConfigured: Bool = false
    private var titleBeforeLoadingStart: String?
    private var imageBeforeStartLoading: UIImage?
    private var initColor: UIColor? = .lightGray
    private let buttonDisableColorHex: Int = 0xD5D5D5
    var needToShowActiveOnStartState: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !wasConfigured else { return }
        setup()
        wasConfigured.toggle()
    }
    
    func setBackgroundColor(color: UIColor) {
        initColor = color
        backgroundColor = color
    }
    
    func setup() {
        backgroundColor = initColor
//        addSubview(loaderView)
        loaderConstraints()
        layer.cornerRadius = frame.height/2
        changeActiveState(isActive: needToShowActiveOnStartState)
     }
    
    func changeActiveState(isActive: Bool) {
        isUserInteractionEnabled = isActive
        if isActive {
            backgroundColor = initColor?.withAlphaComponent(1)
        } else {
            safetySaveColor()
            backgroundColor = initColor?.withAlphaComponent(0.2)
        }
    }
    
    func showLoader(toggle: Bool) {
        isUserInteractionEnabled = !toggle
        if toggle {
            titleBeforeLoadingStart = titleLabel?.text
            imageBeforeStartLoading = self.imageView?.image
            safetySaveColor()
            setTitle("", for: .normal)
            setImage(nil, for: .normal)
            backgroundColor = UIColor(netHex: buttonDisableColorHex)
//            loaderView.startAnimating()
        } else {
//            loaderView.stopAnimating()
            setTitle(titleBeforeLoadingStart ?? "", for: .normal)
            setImage(imageBeforeStartLoading, for: .normal)
            backgroundColor = initColor
        }
    }
    
    private func safetySaveColor() {
        guard backgroundColor != UIColor(netHex: buttonDisableColorHex) else { return }
        initColor = backgroundColor
    }
    
    private func loaderConstraints() {
//        loaderView.centerXAnchor.constraint(equalTo: loaderView.superview!.centerXAnchor).isActive = true
//        loaderView.centerYAnchor.constraint(equalTo: loaderView.superview!.centerYAnchor).isActive = true
//        loaderView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
//        loaderView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
//        loaderView.translatesAutoresizingMaskIntoConstraints = false
    }
}

