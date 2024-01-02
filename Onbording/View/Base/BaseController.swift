

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupLayout()
        setupAppearance()
        setupBehavior()
    }
}

@objc extension BaseController {
    func embedViews() {}
    
    func setupLayout() {}
    
    func setupAppearance() {
        view.backgroundColor = .white
    }
    
    func setupBehavior() {}
}


