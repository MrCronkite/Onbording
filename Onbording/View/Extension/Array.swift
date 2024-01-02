

import UIKit
import SnapKit

extension Array where Element: UIView {
    func updateConstraintsForOnboardingView(at index: Int, in view: UIView) {
        guard index < count else { return }
        
        self[index].snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-1000)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-1000)
        }
        view.layoutIfNeeded()
        
        if index + 1 < count {
            self[index + 1].snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-170)
                make.leading.equalTo(view.snp_leadingMargin).offset(10)
                make.trailing.equalTo(view.snp_trailingMargin).offset(-10)
            }
        }
        
        if index == 0 && index + 2 < count {
            self[index + 2].snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-158)
                make.leading.equalTo(view.snp_leadingMargin).offset(20)
                make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
            }
        }
        
        view.layoutIfNeeded()
    }
    
    func updateConstraintsForOnboardingViewBack(at index: Int, in view: UIView) {
        self[index].snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-170)
            make.leading.equalTo(view.snp_leadingMargin).offset(10)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
        }
        view.layoutIfNeeded()
        
        if index + 1 < count {
            self[index + 1].snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-158)
                make.leading.equalTo(view.snp_leadingMargin).offset(20)
                make.trailing.equalTo(view.snp_trailingMargin).offset(-20)
            }
        }
        view.layoutIfNeeded()
        
        if index == 0 && index + 2 < count {
            self[index + 2].snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-146)
                make.leading.equalTo(view.snp_leadingMargin).offset(30)
                make.trailing.equalTo(view.snp_trailingMargin).offset(-30)
            }
        }
        view.layoutIfNeeded()
    }
}


