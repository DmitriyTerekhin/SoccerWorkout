//
//  UISearchBarExt.swift
//  LogoGenerator
//
//  Created by Дмитрий Терехин on 27.07.2023.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField {
        if #available(iOS 13, *) {
            return searchTextField
        } else {
            return self.value(forKey: "_searchField") as! UITextField
        }
    }

    func setupSearchBar(background: UIColor = .white,
                        placeholderText: UIColor = .gray,
                        imageColor: UIColor = .black,
                        cornerRadius: CGFloat = 18,
                        hideSearchFieldBackgroundImage: Bool = true,
                        placeHolderText: String? = nil,
                        placeHolderFont: UIFont = UIFont(font: .PoppinsMedium, size: 14),
                        foregroundColor: UIColor = UIColor.white,
                        foregroundFont: UIFont = UIFont(font: .PoppinsMedium, size: 14)
    ) {
        
        self.searchBarStyle = .minimal

        self.barStyle = .black
        
        if hideSearchFieldBackgroundImage {
            setSearchFieldBackgroundImage(UIImage(), for: .normal)
        }
        
        let defaultTextAttributes = [
            NSAttributedString.Key.font: foregroundFont,
            NSAttributedString.Key.foregroundColor: foregroundColor
        ]

        // IOS 12 and lower:
        for view in self.subviews {

            for subview in view.subviews {
                if subview is UITextField {
                    if let textField: UITextField = subview as? UITextField {

                        // Background Color
                        textField.backgroundColor = background

                        //   Text Color
                        textField.attributedText = NSAttributedString(string: "",
                                                                      attributes: defaultTextAttributes)

                        //  Placeholder Color
                        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText ?? textField.placeholder ?? "",
                                                                             attributes: [
                                                                                NSAttributedString.Key.foregroundColor : placeholderText,
                                                                                NSAttributedString.Key.font: placeHolderFont
                                                                             ])

                        //  Default Image Color
                        if let leftView = textField.leftView as? UIImageView {
                            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                            leftView.tintColor = imageColor
                        }

                        let backgroundView = textField.subviews.first
                        backgroundView?.backgroundColor = background
                        textField.layer.cornerRadius = cornerRadius
                        textField.clipsToBounds = true
                    }
                }
            }

        }

        // IOS 13 only:
        if let textField = self.value(forKey: "searchField") as? UITextField {
            
            textField.background = UIImage()
            
            // Background Color
            textField.backgroundColor = background
            textField.layer.cornerRadius = cornerRadius
            textField.clipsToBounds = true
            //   Text Color
            textField.attributedText = NSAttributedString(string: "",
                                                          attributes: defaultTextAttributes)
            //  Placeholder Color
            textField.attributedPlaceholder = NSAttributedString(
                string: placeHolderText ?? textField.placeholder ?? "",
                attributes: [
                    NSAttributedString.Key.foregroundColor : placeholderText,
                    NSAttributedString.Key.font: placeHolderFont
                ])

            //  Default Image Color
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = imageColor
            }
            
            if let rightView = textField.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                rightView.tintColor = imageColor
            }
        }
        
        if #available(iOS 13.0, *) {
            searchTextField.textColor = foregroundColor
            searchTextField.backgroundColor = background
        }

    }
    
    func addPadding(_ padding: UITextField.PaddingSide) {
        // IOS 12 and lower:
        for view in self.subviews {
            for subview in view.subviews {
                if subview is UITextField {
                    if let textField: UITextField = subview as? UITextField {
                        textField.addPadding(padding)
                    }
                }
            }
        }
        // IOS 13 only:
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.addPadding(padding)
        }
    }
    
    func prepareForNavigationBarLayout() {
        // IOS 12 and lower:
        for view in self.subviews {
            for subview in view.subviews {
                if subview is UITextField {
                    textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
                    textField.bottomAnchor.constraint(equalTo: textField.superview!.bottomAnchor, constant: -24).isActive = true
                    textField.centerXAnchor.constraint(equalTo: textField.superview!.centerXAnchor).isActive = true
                    textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
                    textField.translatesAutoresizingMaskIntoConstraints = false
                }
            }
        }
        // IOS 13 only:
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
            textField.centerXAnchor.constraint(equalTo: textField.superview!.centerXAnchor).isActive = true
            textField.bottomAnchor.constraint(equalTo: textField.superview!.bottomAnchor, constant: -24).isActive = true
            textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
