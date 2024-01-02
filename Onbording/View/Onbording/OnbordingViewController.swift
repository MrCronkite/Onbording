

import UIKit
import SnapKit

final class OnbordingViewController: BaseController {
    
    private var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private var currentIndex: Int = 0
    private let bottomContainerView = UIView()
    private let continueButton = UIButton()
    private let previewButton = UIButton()
    private let closeControllerButton = UIButton()
    
    private var gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    override func viewDidLayoutSubviews() {
        bottomContainerView.dropShadow(
            color: .lightGray,
            opacity: 0.4,
            offSet: CGSize(width: -2, height: -4),
            radius: 10
        )
    }
}

extension OnbordingViewController {
    override func embedViews() {
        super.embedViews()
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        view.addSubview(bottomContainerView)
        
        [
            continueButton,
            previewButton,
            closeControllerButton
        ].forEach {
            bottomContainerView.addSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        bottomContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
            make.height.equalTo(100)
        }
        
        previewButton.snp.makeConstraints { make in
            make.leading.equalTo(bottomContainerView.snp.leading).offset(20)
            make.centerY.equalTo(bottomContainerView.snp_centerYWithinMargins).offset(0)
        }
        
        continueButton.snp.makeConstraints { make in
            make.trailing.equalTo(bottomContainerView.snp.trailing).offset(-20)
            make.centerY.equalTo(bottomContainerView.snp_centerYWithinMargins).offset(0)
        }
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        previewButton.setTitle(R.Strings.previewButton.uppercased(), for: .normal)
        previewButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        continueButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        bottomContainerView.backgroundColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.bottomContainerView.animateGradientColors()
        }
    }
    
    override func setupBehavior() {
        super.setupBehavior()
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.didMove(toParent: self)
        
        continueButton.addTarget(self, action: #selector(showNextController), for: .touchUpInside)
        previewButton.addTarget(self, action: #selector(showPreviewController), for: .touchUpInside)
    }
}

private extension OnbordingViewController {
    func setupPageViewController() {
        if let firstViewController = viewControllerBeforeAtIndex(0) {
            pageViewController.setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
        
        continueButton.setTitle(R.Strings.startButton.uppercased(), for: .normal)
        previewButton.isHidden = true
    }
    
    func viewControllerAfterAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index <= 2 {
            let contentViewController = ContainerViewController(
                index: index,
                direction: .forward,
                delegate: self
            )
            return contentViewController
        } else if index == 3 {
            dismiss(animated: true)
        }
        return nil
    }
    
    func viewControllerBeforeAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < 3 {
            let contentViewController = ContainerViewController(
                index: index,
                direction: .reverse,
                delegate: self
            )
            return contentViewController
        }
        return nil
    }
}

@objc extension OnbordingViewController {
    func showNextController() {
        if currentIndex <= 3 {
            currentIndex += 1
            if let nextViewController = viewControllerAfterAtIndex(currentIndex) {
                pageViewController.setViewControllers(
                    [nextViewController],
                    direction: .forward,
                    animated: true,
                    completion: nil
                )
            }
        }
    }
    
    func showPreviewController() {
        if currentIndex > 0 {
            currentIndex -= 1
            if let previewViewController = viewControllerBeforeAtIndex(currentIndex) {
                pageViewController.setViewControllers(
                    [previewViewController],
                    direction: .reverse,
                    animated: true,
                    completion: nil
                )
            }
        }
    }
}

extension OnbordingViewController: UIPageViewControllerDataSource {}

extension OnbordingViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let containerViewController = viewController as? ContainerViewController else { return nil }
        let index = containerViewController.index
        
        if index > 1 {
            return ContainerViewController(
                index: index - 1,
                direction: .reverse,
                delegate: self
            )
        } else if index == 1 {
            return ContainerViewController(
                index: index - 1,
                direction: .reverse,
                delegate: self
            )
        }
        return nil
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let containerViewController = viewController as? ContainerViewController else { return nil }
        let index = containerViewController.index
        
        if index < 2 {
            currentIndex += 1
            return ContainerViewController(
                index: index + 1, 
                direction: .forward,
                delegate: self
            )
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard
            let currentViewController = pageViewController.viewControllers?.first as? ContainerViewController,
            let nextViewController = pendingViewControllers.first as? ContainerViewController
        else { return }
        
        let currentIndex = currentViewController.index
        let nextIndex = nextViewController.index
        
        if nextIndex > currentIndex {
            self.currentIndex = nextIndex
        } else if nextIndex < currentIndex {
            self.currentIndex = nextIndex
        }
    }
}

extension OnbordingViewController: ContainerViewControllerDelegate {
    func setupButtonAppearance(index: Int) {
        if index == currentIndex {
            switch currentIndex {
            case 1:
                previewButton.isHidden = false
                continueButton.setTitle(R.Strings.nextButton.uppercased(), for: .normal)
                previewButton.setTitleColor(.lightGray, for: .normal)
                continueButton.setTitleColor(.lightGray, for: .normal)
                bottomContainerView.removeGradientLayers()
            case 2:
                continueButton.setTitle(R.Strings.closeButton.uppercased(), for: .normal)
                previewButton.setTitleColor(.white, for: .normal)
                continueButton.setTitleColor(.white, for: .normal)
                bottomContainerView.animateGradientColors()
            case 0:
                previewButton.isHidden = true
                continueButton.setTitle(R.Strings.startButton.uppercased(), for: .normal)
                previewButton.setTitleColor(.white, for: .normal)
                continueButton.setTitleColor(.white, for: .normal)
                bottomContainerView.animateGradientColors()
            default:
                return
            }
        }
    }
}
