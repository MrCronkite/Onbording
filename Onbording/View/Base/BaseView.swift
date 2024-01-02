

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupLayout()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        embedViews()
        setupLayout()
        setupAppearance()
    }
}

@objc extension BaseView {
    func embedViews() {}
    
    func setupLayout() {}
    
    func setupAppearance() {
        self.backgroundColor = .white
    }
}
