

import UIKit

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}

extension UITableView {
    
    func registerCell(reusable: ReusableView.Type) {
        register(reusable, forCellReuseIdentifier: reusable.reuseID)
    }
    
    func registerFooterHeader(reusable:  ReusableView.Type) {
        register(reusable, forHeaderFooterViewReuseIdentifier: reusable.reuseID)
    }
    
    func dequeueCell<T>(at indexPath: IndexPath)  -> T where  T: UITableViewCell {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unexpected ReusableCell Type for reuseID \(T.reuseID)")
        }
        return cell
    }
    
    func dequeueView<T>() -> T where  T: UITableViewHeaderFooterView {
        
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseID) as? T else {
            fatalError("Unexpected ReusableView Type for reuseID \(T.reuseID)")
        }
        return cell
    }
    
    func reloadWithoutScroll(at indexPAth: [IndexPath]) {
        let offset = contentOffset
        reloadRows(at: indexPAth, with: .none)
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
    }
    
    func scrollToSectionTop(_ section: Int) {
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else { return }
            guard self.numberOfRows(inSection: section) > 0 else { return }
            let indexPath = IndexPath(row: NSNotFound, section: section)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

extension UITableView {

    func reloadWithoutAnimation() {
        let lastScrollOffset = contentOffset
        beginUpdates()
        endUpdates()
        layer.removeAllAnimations()
        setContentOffset(lastScrollOffset, animated: false)
    }
}

extension UITableView {
    
    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size =  header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
    
    func setAndLayoutTableFooterView(footer: UIView) {
        self.tableFooterView = footer
        NSLayoutConstraint.activate([
            footer.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        footer.setNeedsLayout()
        footer.layoutIfNeeded()
        footer.frame.size =  footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableFooterView = footer
    }
}

extension UITableView {
   static func numberToArray(number: Int) -> [Int] {
        guard number > 0 else {return []}
        var array: [Int] = []
        for value in 0..<number {
            array.append(value)
        }
        return array
    }
}
