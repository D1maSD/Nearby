//
//  CustomNavigationBarView.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//

import UIKit

enum NavigationType {
    case white
    case mustard
    case createEvent
    case mustardWithoutExit
    case withCross
    case clear
    case mustardWithCross
    case peopleGoFilter
    case clearWithoutExit

    var barColor: UIColor {
        switch self {
        case .white:
            return .white
        case .mustard, .mustardWithoutExit, .createEvent, .mustardWithCross, .peopleGoFilter:
            return .yellow
        case .clear, .withCross, .clearWithoutExit:
            return .clear
        }
    }

    var backButtonImage: UIImage? {
        switch self {
        case .white:
            return UIImage(named: "backArrow")
        case .mustard, .clear:
            return UIImage(named: "backArrowWhite")
        case .mustardWithoutExit, .createEvent, .clearWithoutExit:
            return nil
        case .withCross, .mustardWithCross, .peopleGoFilter:
            return UIImage(named: "crossWhite")
        }
    }
}

protocol CustomNavigationBarViewDelegate: AnyObject {
    func backTapped()
    func rightButtonTapped()
}

class CustomNavigationBarView: UIView {

    private weak var delegate: CustomNavigationBarViewDelegate?

    var textTitle = "" {
        didSet {
            setupTitleLabel()
        }
    }

    private let backButton = UIButton()
    private let rightButton = UIButton()

    var rightButtonIsEnabled: Bool {
        get {
            return rightButton.isEnabled
        }
        set (newValue) {
            rightButton.titleLabel?.alpha = newValue ?  1 : 0.5
            rightButton.isEnabled = newValue
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.logoSubtitleFont
        label.textColor = .white
        return label
    }()

    init(_ delegate: CustomNavigationBarViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupBackButton()
        setupRightButton()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ type: NavigationType) {
        backgroundColor = type.barColor
        backButton.setImage(type.backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        switch type {
        case .peopleGoFilter:
            rightButton.isHidden = false
            rightButton.setTitle("L10n.Filter.reset", for: .normal)
            rightButton.titleLabel?.font = UIFont.logoSubtitleFont
        default:
            rightButton.isHidden = true
        }
    }

    func setupRightButton() {
        rightButton.addTarget(self, action: #selector(tapRightButton), for: .touchUpInside)
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-11)
            make.centerY.equalTo(snp.centerY)
        }
    }

    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.size.equalTo(36)
            make.leading.equalTo(snp.leading).offset(6)
        }
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
        titleLabel.text = textTitle
    }

    @objc private func tapBackButton() {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
            self.backButton.alpha = 0.7
        } completion: { _ in
            self.backButton.alpha = 1
        }
        delegate?.backTapped()
    }

    @objc private func tapRightButton() {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
            self.rightButton.alpha = 0.7
        } completion: { _ in
            self.rightButton.alpha = 1
        }
        delegate?.rightButtonTapped()
    }
}
