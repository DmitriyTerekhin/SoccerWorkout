//
//  EnterCollectionViewCell.swift
//

import UIKit

class EnterCollectionViewCell: UICollectionViewCell, ReusableView {
    
    enum Constants {
        static let buttonHeight: CGFloat = 66
        static let buttonWidth: CGFloat = 248
        static let pushTitle = "Remember to workout"
        static let pushSubtitle = "\nConnect push notifications so that we can notify you about upcoming training sessions on time"
        static let termsAndPrivacy = "Terms of use and Privacy Policy"
        static let signTitle = "Sign up now"
        static let signSubtitle = "\nStart training right now by connecting your Apple Account in one click"
        static let termsWords = "Terms"
        static let privacyWords = "Privacy Policy"
        static let signUpTitleButton = "Sign up"
        static let notifyButtonTitle = "Notifying me"
        static let notNotifyTitle = "Set up later"
    }
    
    private let iconImageView: UIImageView = {
        let ic = UIImageView()
        return ic
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.setFont(fontName: .PoppinsMedium, sizeXS: 18)
        return lbl
    }()
    
    private let termsAndPrivacyPolicyLinkLabel: InteractiveLinkLabel = {
        let lbl = InteractiveLinkLabel()
        lbl.numberOfLines = 0
        lbl.setFont(fontName: .PoppinsRegular, sizeXS: 16)
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.isHidden = true
        lbl.isUserInteractionEnabled = true
        lbl.addText(text: Constants.termsAndPrivacy,
                    wordsAndSiteToGo: [
                        Constants.termsWords: "https://doc-hosting.flycricket.io/bno-sport-way-terms-of-use/2ed3d3c7-ca8e-4c3a-a3ce-0e15526b2ae6/terms",
                        Constants.privacyWords: "https://doc-hosting.flycricket.io/bno-sport-way-privacy-policy/82566c48-4495-46af-8f5e-9a4ac88d40f8/privacy"
                    ],
                    linksColor: .white,
                    originalTextColor: UIColor.white,
                    linksFont: UIFont(font: .PoppinsRegular, size: 16)
        )
        return lbl
    }()
    
    private let termsAndPolicyTextView: UITextView = {
        let txtV = UITextView()
        txtV.textColor = .white
        txtV.text = Constants.termsAndPrivacy
        txtV.backgroundColor = .clear
        txtV.isHidden = true
        return txtV
    }()
    
    private let topButton: CustomButton = {
        let btn = CustomButton(type: .system)
        btn.setTitleColor(.white, for: .normal)
        btn.changeActiveStatus(isActive: true)
        btn.titleEdgeInsets.left = 5
        btn.titleEdgeInsets.right = 5
        btn.titleLabel?.setFont(fontName: .PoppinsRegular, sizeXS: 18)
        return btn
    }()
    
    private let bottomButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .PoppinsRegular, sizeXS: 18)
        btn.layer.cornerRadius = 14
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setuConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.AppCollors.background
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomButton)
        contentView.addSubview(topButton)
        contentView.addSubview(termsAndPolicyTextView)
        contentView.addSubview(termsAndPrivacyPolicyLinkLabel)
    }
    
    func setupWith(_ model: EnterLogicType) {
        switch model {
        case .notification:
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            style.paragraphSpacingBefore = 8
            let defaultAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 18),
                .foregroundColor: UIColor.white,
                .paragraphStyle: style
            ] as [NSAttributedString.Key : Any]

            let style2 = NSMutableParagraphStyle()
            style2.alignment = NSTextAlignment.left
            style2.paragraphSpacingBefore = 8
            let lowAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.defaultGray,
                .paragraphStyle: style2
            ] as [NSAttributedString.Key : Any]

            let attributedStringComponents = [
                NSAttributedString(string: Constants.pushTitle,
                                         attributes: defaultAttributes),
                NSAttributedString(string: Constants.pushSubtitle,
                                         attributes: lowAttributes)
            ] as [AttributedStringComponent]
            titleLabel.attributedText = NSAttributedString(from: attributedStringComponents, defaultAttributes: defaultAttributes)
            iconImageView.image = UIImage(named: "NotificationTopImage")
            topButton.setTitle(Constants.notifyButtonTitle, for: .normal)
            bottomButton.setTitle(Constants.notNotifyTitle, for: .normal)
            topButton.addTarget(nil, action: #selector(EnterViewController.allowNotificationTapped), for: .touchUpInside)
            bottomButton.addTarget(nil, action: #selector(EnterViewController.noThanksTapped), for: .touchUpInside)
        case .signIn:
            prepareAttributesForTextView()
            termsAndPrivacyPolicyLinkLabel.isHidden = false
            termsAndPolicyTextView.isHidden = true
            bottomButton.isHidden = true
            iconImageView.image = UIImage(named: "SignInTopImage")
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            style.paragraphSpacingBefore = 8
            let defaultAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 18),
                .foregroundColor: UIColor.white,
                .paragraphStyle: style
            ] as [NSAttributedString.Key : Any]

            let style2 = NSMutableParagraphStyle()
            style2.alignment = NSTextAlignment.left
            style2.paragraphSpacingBefore = 8
            let lowAttributes = [
                .font: UIFont(font: .PoppinsMedium, size: 14),
                .foregroundColor: UIColor.AppCollors.defaultGray,
                .paragraphStyle: style2
            ] as [NSAttributedString.Key : Any]

            let attributedStringComponents = [
                NSAttributedString(string: Constants.signTitle,
                                         attributes: defaultAttributes),
                NSAttributedString(string: Constants.signSubtitle,
                                         attributes: lowAttributes)
            ] as [AttributedStringComponent]
            let attributedString = NSMutableAttributedString(from: attributedStringComponents, defaultAttributes: defaultAttributes)
            titleLabel.attributedText = attributedString

            let buttonAttributes = [
                .font: UIFont(font: .PoppinsRegular, size: 16),
                .foregroundColor: UIColor.white
            ] as [NSAttributedString.Key : Any]
            
            let attributedButttonComponents = [
                NSAttributedString(string: Constants.termsAndPrivacy,
                                         attributes: buttonAttributes),
            ] as [AttributedStringComponent]
            let buttonAttributedString = NSMutableAttributedString(from: attributedButttonComponents, defaultAttributes: buttonAttributes)
            let rangeTerms = (Constants.termsAndPrivacy as NSString).range(of: Constants.termsWords)
            buttonAttributedString?.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: rangeTerms)
            let rangePrivacy = (Constants.termsAndPrivacy as NSString).range(of: Constants.privacyWords)
            buttonAttributedString?.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: rangePrivacy)
            bottomButton.setAttributedTitle(buttonAttributedString, for: .normal)
            topButton.setTitle(Constants.signUpTitleButton, for: .normal)
            bottomButton.tintColor = .white
            topButton.addTarget(nil, action: #selector(EnterViewController.signInWithAppleTapped), for: .touchUpInside)
        }
    }
    
    private func setuConstraints() {
        // Icon
        iconImageView.rightAnchor.constraint(equalTo: iconImageView.superview!.rightAnchor, constant: 0).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: iconImageView.superview!.leftAnchor, constant: 0).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: iconImageView.superview!.centerYAnchor, constant: 0).isActive = true
        iconImageView.topAnchor.constraint(equalTo: iconImageView.superview!.topAnchor, constant: 0).isActive = true
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 32).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleLabel.superview!.leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: -30).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Buttons
        bottomButton.bottomAnchor.constraint(equalTo: bottomButton.superview!.bottomAnchor, constant: -32).isActive = true
        bottomButton.leftAnchor.constraint(equalTo: bottomButton.superview!.leftAnchor, constant: 24).isActive = true
        bottomButton.rightAnchor.constraint(equalTo: bottomButton.superview!.rightAnchor, constant: -24).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        topButton.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -8).isActive = true
        topButton.centerXAnchor.constraint(equalTo: topButton.superview!.centerXAnchor).isActive = true
        topButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        topButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth).isActive = true
        topButton.translatesAutoresizingMaskIntoConstraints = false
        
        termsAndPolicyTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        termsAndPolicyTextView.widthAnchor.constraint(equalTo: bottomButton.widthAnchor).isActive = true
        termsAndPolicyTextView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -31).isActive = true
        termsAndPolicyTextView.centerXAnchor.constraint(equalTo: termsAndPolicyTextView.superview!.centerXAnchor).isActive = true
        termsAndPolicyTextView.translatesAutoresizingMaskIntoConstraints = false
        
        termsAndPrivacyPolicyLinkLabel.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 31).isActive = true
        termsAndPrivacyPolicyLinkLabel.centerXAnchor.constraint(equalTo: topButton.centerXAnchor).isActive = true
        termsAndPrivacyPolicyLinkLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func prepareAttributesForTextView() {
        let text = (termsAndPolicyTextView.text ?? "") as NSString
        termsAndPolicyTextView.font = UIFont(font: .PoppinsRegular, size: 18)
        let attributedString = termsAndPolicyTextView.addHyperLinksToText(
            originalText: text as String, hyperLinks: [
                Constants.privacyWords: "\(ApiConstants.URL.privacyBase)/privacy-policy.html",
                Constants.termsWords: "\(ApiConstants.URL.privacyBase)/end-user-licence-agreement.html"
            ],
            font:  UIFont(font: .PoppinsRegular, size: 18)
        )
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        termsAndPolicyTextView.linkTextAttributes = linkAttributes
        termsAndPolicyTextView.textColor = .white
        termsAndPolicyTextView.textAlignment = .center
        termsAndPolicyTextView.isUserInteractionEnabled = true
        termsAndPolicyTextView.isEditable = false
        termsAndPolicyTextView.attributedText = attributedString
    }
}

protocol AttributedStringComponent {
    var text: String { get }
    func getAttributes() -> [NSAttributedString.Key: Any]?
}

// MARK: String extensions

extension String: AttributedStringComponent {
    var text: String { self }
    func getAttributes() -> [NSAttributedString.Key: Any]? { return nil }
}

extension String {
    func toAttributed(with attributes: [NSAttributedString.Key: Any]?) -> NSAttributedString {
        .init(string: self, attributes: attributes)
    }
}

// MARK: NSAttributedString extensions

extension NSAttributedString: AttributedStringComponent {
    var text: String { string }

    func getAttributes() -> [Key: Any]? {
        if string.isEmpty { return nil }
        var range = NSRange(location: 0, length: string.count)
        return attributes(at: 0, effectiveRange: &range)
    }
}

extension NSAttributedString {

    convenience init?(from attributedStringComponents: [AttributedStringComponent],
                      defaultAttributes: [NSAttributedString.Key: Any],
                      joinedSeparator: String = " ") {
        switch attributedStringComponents.count {
        case 0: return nil
        default:
            var joinedString = ""
            typealias SttributedStringComponentDescriptor = ([NSAttributedString.Key: Any], NSRange)
            let sttributedStringComponents = attributedStringComponents.enumerated().flatMap { (index, component) -> [SttributedStringComponentDescriptor] in
                var components = [SttributedStringComponentDescriptor]()
                if index != 0 {
                    components.append((defaultAttributes,
                                       NSRange(location: joinedString.count, length: joinedSeparator.count)))
                    joinedString += joinedSeparator
                }
                components.append((component.getAttributes() ?? defaultAttributes,
                                   NSRange(location: joinedString.count, length: component.text.count)))
                joinedString += component.text
                return components
            }

            let attributedString = NSMutableAttributedString(string: joinedString)
            sttributedStringComponents.forEach { attributedString.addAttributes($0, range: $1) }
            self.init(attributedString: attributedString)
        }
    }
}

private extension UITextView {
    func addHyperLinksToText(originalText: String, hyperLinks: [String: String], font: UIFont, textAlignment: NSTextAlignment = .center) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        for (hyperLink, urlString) in hyperLinks {
            let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
            attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: font, range: fullRange)
        }
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: fullRange)
        return attributedOriginalText
    }
}
