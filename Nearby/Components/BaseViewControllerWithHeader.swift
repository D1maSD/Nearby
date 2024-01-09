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

    var backTap: (() -> Void)?
    var navigationBar: CustomNavigationBarView?
    var rightButttonTap: (() -> Void)?
    var navBarTitle: ((String) -> Void)?
    var navigationType: NavigationType?
    var topOffset: CGFloat {
        return view.theRightDistanceFromTheTop() + addedToTopOffset
    }
    var needToMoveScreenWithKeyboard: Bool { false }

    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

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
        plugShown = false
    }

    func bindKeyboard(_ viewBinding: UIView, originY: CGFloat? = nil, cancelsTouchesInView: Bool = false) {
        viewForKeyboardBinding = viewBinding
        originYKeyBindingView = originY
    }
}


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

protocol LostConnectionHandler: BaseViewController {
    func bindInternetConnectionObserver()
}
