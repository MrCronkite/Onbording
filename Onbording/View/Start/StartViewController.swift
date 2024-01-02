

import UIKit
import SnapKit

class StartViewController: BaseController {
    
    private let startTextLable = UILabel()
    private let startBottomView = UIView()
    private let startButtonShowOnbording = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        startBottomView.animateGradientColors()
    }
}

extension StartViewController {
    override func embedViews() {
        super.embedViews()
        [
            startTextLable,
            startBottomView
        ].forEach {
            view.addSubview($0)
        }
        
        startBottomView.addSubview(startButtonShowOnbording)
    }
    
    override func setupLayout() {
        super.setupLayout()
        startTextLable.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp_centerYWithinMargins).offset(0)
            make.centerX.equalTo(view.snp_centerXWithinMargins).offset(0)
        }
        
        startBottomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
            make.height.equalTo(100)
        }
        
        startButtonShowOnbording.snp.makeConstraints { make in
            make.trailing.equalTo(startBottomView.snp.trailing).offset(-20)
            make.centerY.equalTo(startBottomView.snp_centerYWithinMargins).offset(0)
        }
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .backgraund_color
        
        startTextLable.text = R.Strings.helloText.uppercased()
        startTextLable.textColor = .black
        startTextLable.font = .systemFont(ofSize: 35, weight: .bold)
        
        startButtonShowOnbording.setTitle(R.Strings.startButton.uppercased(), for: .normal)
        startButtonShowOnbording.setTitleColor(.white, for: .normal)
        startButtonShowOnbording.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    override func setupBehavior() {
        super.setupBehavior()
        startButtonShowOnbording.addTarget(self, action: #selector(showOnbording), for: .touchUpInside)
    }
}

@objc extension StartViewController {
    func showOnbording() {
        let vc = OnbordingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

