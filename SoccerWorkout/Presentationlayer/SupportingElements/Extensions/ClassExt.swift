//
//  ClassExt.swift
//

import UIKit

protocol ReusableView: AnyObject {
    static var reuseID: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseID: String {
        return NSStringFromClass(self)
    }
}
