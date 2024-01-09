//
//  BaseViewControllerWithHeader.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 01.01.2024.
//

import UIKit

enum HeaderBackButton {
    case none
    case backArrowBlack
    case crossWhite
}

enum ControllerWithHeaderType {
    case withChooseCity
    case withoutChooseCity
    case withTitle(title: String, backButton: HeaderBackButton)
    case withoutBackgroundColor
}

class BaseControllerWithHeader: BaseViewController {
    internal lazy var headerView = MainHeaderView(type: type, delegate: self)
    internal var titleController: String = ""

    var tapChooseCity: (() -> Void)?
    var backButtonTap: (() -> Void)?
    private let type: ControllerWithHeaderType

    init(type: ControllerWithHeaderType, addToTopOffset: CGFloat = 0) {
        self.type = type
        super.init(addToTopOffset: addToTopOffset)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupUI() {
        setupHeader()
    }

    private func setupHeader() {
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension BaseControllerWithHeader: MainHeaderViewDelegate {
    func tapOnBackButton() {
        backButtonTap?()
    }

    func tapOnChooseCity() {
        tapChooseCity?()
    }
}














import UIKit
import SnapKit

class BaseViewController: UIViewController {

//    var reachabilityManager: ReachabilityManagerBridgeProtocol?

    var backTap: (() -> Void)?
    var navigationBar: CustomNavigationBarView?
    var rightButttonTap: (() -> Void)?
    var navBarTitle: ((String) -> Void)?
    var navigationType: NavigationType?
    var topOffset: CGFloat {
        return view.theRightDistanceFromTheTop() + addedToTopOffset
    }
    var needToMoveScreenWithKeyboard: Bool { false }
//    var customTabBar: CustomTabBar? {
//        guard
//            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
//            let tabBarController = appDelegate.window?.rootViewController as? TabBarController
//        else { return nil }
//        return tabBarController.customTabBar
//    }

//    var containerBottomOffset: Int {
//        Int((customTabBar?.frame.height ?? 56) + safeAreaBottomPadding)
//    }

    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

//    private let plug = UniverslaLostConnectionPlug()

    private var safeAreaBottomPadding: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    }

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var plugShown: Bool = false
//    private var plugView = PlugView()
    private var addedToTopOffset: CGFloat
    private var viewForKeyboardBinding: UIView?
    private var originYKeyBindingView: CGFloat?
    private let isIPhoneWithBangs: Bool = { return UIScreen.main.bounds.height >= 812 }()

    init(addToTopOffset: CGFloat = 0) {
        addedToTopOffset = addToTopOffset
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func viewDidLoad() {
//        reachabilityManager = ReachabilityManagerBridge()
        view.backgroundColor = UIColor(hex:"#FAF9F9")
    }

    override func viewWillAppear(_ animated: Bool) {
        if viewForKeyboardBinding == nil {
            setingUIWithoutKeyboard()
        } else {
            settingUiForKeyboard()
        }
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
//        plug.remove()
        plugShown = false
//        removeKeyboardObservers()
    }

    func bindKeyboard(_ viewBinding: UIView, originY: CGFloat? = nil, cancelsTouchesInView: Bool = false) {
        viewForKeyboardBinding = viewBinding
        originYKeyBindingView = originY
//        removeKeyboardObservers()
//        registerKeyboardObservers(cancelsTouchesInView: cancelsTouchesInView)
    }

//    func showPlugView(type: PlugViewType,
//                      viewForBindingTop: ConstraintRelatableTarget,
//                      topOffset: Int = 0,
//                      addToBottomOffset: Int = 0,
//                      buttonTap: @escaping () -> Void?) {
//        plugView.isHidden = false
//        plugView.configure(type: type, completion: buttonTap)
//        contentView.addSubview(plugView)
//        plugView.snp.makeConstraints { make in
//            make.top.equalTo(viewForBindingTop).offset(topOffset)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-56 - addToBottomOffset)
//        }
//        if type == .createEvent { plugView.isUserInteractionEnabled = false }
//    }
//
//    func hidePlugView() {
//        plugView.isHidden = true
//    }
}

//extension BaseViewController: KeyboardPresentable {
//    func keyboardWillShow(_ notification: Notification) {
//        keyboardWillShow(notification: notification as NSNotification)
//    }
//
//    func dismissKeyboard(_ recognizer: UITapGestureRecognizer) {
//        view.endEditing(true)
//    }
//
//    func keyboardWillHide(_ notification: Notification) {
//        keyboardWillHide(notification: notification as NSNotification)
//    }
//}

// MARK: Simple Keyboard bind methods
extension BaseViewController {
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }

        if let activeTextField = viewForKeyboardBinding {

            let bottomOfBindView = activeTextField.convert(activeTextField.bounds, to: contentView).maxY
            let topOfKeyboard = contentView.frame.height - keyboardSize.height

            if bottomOfBindView > topOfKeyboard {// TODO: Не ланает, и не работает при вызове datePicker( у него почему то 635 высота )
                var offset = topOfKeyboard - bottomOfBindView - 10
                print(-keyboardSize.height)
                if offset <= -100, needToMoveScreenWithKeyboard {
                    offset = -22
                }
                contentView.frame.origin.y = offset < -keyboardSize.height ? -keyboardSize.height : offset
            }
        }
    }

    private func keyboardWillHide(notification: NSNotification) {
        if isIPhoneWithBangs {
            contentView.frame.origin.y = -3
        } else {
            contentView.frame.origin.y = 0
        }
        guard let originYKeyBindingView = originYKeyBindingView else { return }
        contentView.frame.origin.y = originYKeyBindingView
    }

    private func settingUiForKeyboard() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        if navigationBar.isHidden {
            view.addSubview(scrollView)
            scrollView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalTo(topOffset)
            }
            scrollView.addSubview(contentView)
            contentView.snp.makeConstraints { make in
                make.height.equalTo(scrollView)
                make.width.equalTo(view)
                if isIPhoneWithBangs {
                    make.top.equalTo(scrollView.snp.top).offset(-3)
                } else {
                    make.top.equalTo(scrollView.snp.top)
                }
                make.bottom.equalTo(view.snp.bottom)
            }
        } else {
            view.addSubview(scrollView)
            scrollView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(view.snp.bottom)
                make.top.equalTo(view.snp.top).offset(topOffset + navigationBar.frame.height)
            }
            scrollView.addSubview(contentView)
            contentView.snp.makeConstraints { make in
                make.height.equalTo(scrollView.snp.height)
                if isIPhoneWithBangs {
                    make.top.equalTo(scrollView.snp.top).offset(-3)
                } else {
                    make.top.equalTo(scrollView.snp.top)
                }
                make.width.equalTo(view.bounds.width)
            }
        }
    }

    private func setingUIWithoutKeyboard() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topOffset)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//extension BaseViewController: LostConnectionHandler {
//    func bindInternetConnectionObserver() {
//        reachabilityManager?.reachability.internetAccessibility = { type in
//            switch type {
//            case .reachable:
//                Toast.show(type: .internetConnectionRestored)
//            case .unreachable:
//                Toast.show(type: .noInternetConnection)
//            }
//        }
//    }

//    func internetLost(addTopOffset: CGFloat = 0, internetRestored: @escaping () -> Void) {
//        if !plugShown {
//            plugShown = true
//            view.layoutIfNeeded()
//            plug.show(containerBottomOffset: containerBottomOffset,
//                      containerTopOffset: Int(UIScreen.main.bounds.height - contentView.frame.height + addTopOffset)) { [weak self] in
//                guard let isRechable = self?.reachabilityManager?.reachability.isReachable else { return }
//                if isRechable {
//                    self?.plug.remove()
//                    self?.plugShown = false
//                    internetRestored()
//                }
//            }
//        }
//    }
//}

protocol LostConnectionHandler: BaseViewController {
    func bindInternetConnectionObserver()
}
