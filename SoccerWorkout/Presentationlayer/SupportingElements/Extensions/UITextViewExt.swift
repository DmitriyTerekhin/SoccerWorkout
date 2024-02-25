//
//  UITextViewExt.swift
//  FootballManager
//

import UIKit

extension UITextView {
    func addHyperLinksToText(originalText: String,
                             hyperLinks: [String: String],
                             textColor: UIColor,
                             font: UIFont) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let rangeOfFullText = attributedOriginalText.mutableString.range(of: originalText)
        attributedOriginalText.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], range: rangeOfFullText)
        for (hyperLink, siteToGo) in hyperLinks {
            let link = NSURL(string: siteToGo)!
            let rangeOfLinkedText = attributedOriginalText.mutableString.range(of: hyperLink)
            let attributes = [
                NSAttributedString.Key.attachment: link,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.font: font
            ] as [NSAttributedString.Key : Any]
            attributedOriginalText.addAttributes(attributes, range: rangeOfLinkedText)
        }
        return attributedOriginalText
    }
}
