//
//  CustomNavigationController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 01.01.2024.
//

import UIKit


class CustomNavigationController: UINavigationController {
    internal lazy var customNavigationBar = CustomNavigationBarView(self)
    private var navigationType: NavigationType = .white
    internal var customNavigationIsHiden: Bool = false {
        didSet {
            customNavigationNeeded(customNavigationIsHiden)
        }
    }

    init(_ rootViewContoller: BaseViewController) {
        super.init(rootViewController: rootViewContoller)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setupCustomNavigation()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCustomNavigation() {
        self.navigationBar.isHidden = true
        self.interactivePopGestureRecognizer?.isEnabled = false
        view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(view.theRightDistanceFromTheTop())
            make.leading.equalTo(view)
            make.width.equalTo(navigationBar.bounds.width)
            make.height.equalTo(navigationBar.bounds.height)
        }
    }

    private func customNavigationNeeded(_ need: Bool) {
        customNavigationBar.isHidden = need
    }

    func pushViewController(_ viewController: BaseViewController, animated: Bool, type: NavigationType) {
        super.pushViewController(viewController, animated: animated)
        viewController.navigationBar = customNavigationBar
        viewController.navigationType = type
        navigationType = type
        viewController.navBarTitle = { [weak self] textTitle in
            self?.customNavigationBar.textTitle = textTitle
        }
        customNavigationBar.configure(type)
    }

    func popToViewController(animated: Bool) {
        let popController = super.popViewController(animated: animated)
        guard let controller = popController as? BaseViewController else { return }
        navigationType = controller.navigationType ?? .white
        customNavigationBar.configure(navigationType)
    }

    func customPopViewController(animated: Bool) {
        super.popViewController(animated: animated)
        guard let controller = viewControllers.last as? BaseViewController else { return }
        navigationType = controller.navigationType ?? .white
        customNavigationBar.configure(navigationType)
    }

    func jumpToTheDesiredController() {
        self.popToRootViewController(animated: true)
    }
}

extension CustomNavigationController: CustomNavigationBarViewDelegate {
    func rightButtonTapped() {
        guard let controller = super.viewControllers.last as? BaseViewController else { return }
        controller.rightButttonTap?()
    }

    func backTapped() {
        guard let controller = super.viewControllers.last as? BaseViewController else { return }
        controller.backTap?()
    }
}
