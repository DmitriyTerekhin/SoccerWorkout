//

import UIKit
import NVActivityIndicatorView

class LoadingFooterView: UIView {
    
    private let loaderView: NVActivityIndicatorView = {
        let v = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: CGFloat(30).dp, height: CGFloat(30).dp),
                                        type: NVActivityIndicatorType.circleStrokeSpin)
        v.color = UIColor.AppCollors.orange
        v.layer.zPosition = 100
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loaderView)
        laoderViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading() {
        loaderView.startAnimating()
    }
    
    func stopLoading() {
        loaderView.stopAnimating()
    }
    
    private func laoderViewConstraints() {
        loaderView.topAnchor.constraint(equalTo: loaderView.superview!.topAnchor, constant: 20).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: loaderView.superview!.bottomAnchor, constant: -20).isActive = true
        loaderView.centerXAnchor.constraint(equalTo: loaderView.superview!.centerXAnchor).isActive = true
        loaderView.widthAnchor.constraint(equalToConstant: CGFloat(30).dp).isActive = true
        loaderView.heightAnchor.constraint(equalToConstant: CGFloat(30).dp).isActive = true
        loaderView.translatesAutoresizingMaskIntoConstraints = false
    }

}
