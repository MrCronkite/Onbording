

import UIKit
import SnapKit

protocol ContainerViewControllerDelegate: AnyObject {
    func setupButtonAppearance(index: Int)
}

final class ContainerViewController: BaseController {
    
    enum Direction {
        case reverse
        case forward
    }
    
    weak var delegat: ContainerViewControllerDelegate?
    
    var index = 0
    private var direction: Direction = .forward
    
    private let firstOnbordingView = OnbordingView()
    private let secondOnbordingView = OnbordingView()
    private let thirdOnbordingView = OnbordingView()
    private var arrayOnbordingView: [OnbordingView] = []
    
    init(index: Int, direction: Direction, delegate: ContainerViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        arrayOnbordingView =  [
            firstOnbordingView,
            secondOnbordingView,
            thirdOnbordingView
        ]
        
        self.direction = direction
        self.index = index
        self.delegat = delegate
        
        setupViewData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        arrayOnbordingView.forEach {
            $0.layer.cornerRadius = 3
            $0.dropShadow(
                color: .lightGray,
                opacity: 0.2,
                offSet: CGSize(width: 2, height: 4),
                radius: 10
            )
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        direction == .forward ? self.showOnbordingView() : self.hideOnbordingView()
        delegat?.setupButtonAppearance(index: index)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
            self.arrayOnbordingView.updateConstraintsForOnboardingViewBack(
                at: 0,
                in: self.view
            )
    }
}

extension ContainerViewController {
    override func embedViews() {
        super.embedViews()
        arrayOnbordingView.reverse()
        arrayOnbordingView.forEach {
            view.addSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        arrayOnbordingView.reverse()
        arrayOnbordingView.enumerated().forEach { index, onboardingView in
            onboardingView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
                make.leading.equalTo(view.snp_leadingMargin).offset(10 + index * 10)
                make.trailing.equalTo(view.snp_trailingMargin).offset(-10 - index * 10)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-170 + index * 12)
            }
        }
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .backgraund_color
    }
}

private extension ContainerViewController {
    func setupViewData() {
        arrayOnbordingView.enumerated().forEach { i, onboardingView in
            onboardingView.setupItems(index: i)
        }
    }
    
    func showOnbordingView() {
        UIView.animate(withDuration: 0.7) {
            switch self.index {
            case 0:
                self.arrayOnbordingView.updateConstraintsForOnboardingView(
                    at: self.index,
                    in: self.view
                )
            case 1:
                self.arrayOnbordingView.updateConstraintsForOnboardingView(
                    at: self.index - 1,
                    in: self.view
                )
            default:
                self.arrayOnbordingView.updateConstraintsForOnboardingView(
                    at: self.index - 2,
                    in: self.view
                )
                
                self.arrayOnbordingView.updateConstraintsForOnboardingView(
                    at: self.index - 1,
                    in: self.view
                )
            }
        }
    }
    
    func hideOnbordingView() {
        UIView.animate(withDuration: 0.7) {
            if self.index == 0 {
                self.arrayOnbordingView.updateConstraintsForOnboardingViewBack(
                    at: self.index,
                    in: self.view
                )
            } else {
                self.arrayOnbordingView.updateConstraintsForOnboardingView(
                    at: self.index - 1,
                    in: self.view
                )
            }
        }
    }
}
