//
//  MainHeaderView.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 01.01.2024.
//

import UIKit
import SnapKit

protocol MainHeaderViewDelegate: AnyObject {
    func tapOnChooseCity()
    func tapOnBackButton()
}

final class MainHeaderView: UIView {

    var titleLabelCenterY: ConstraintItem {
        titleLabel.snp.centerY
    }

    var logoIsHidden: Bool = false {
        didSet {
            logoImage.isHidden = logoIsHidden
        }
    }

    lazy var chooseCity: UITextField = {
        let text = UITextField()
        text.font = UIFont.logoSubtitleFont
        text.backgroundColor = .white
        text.layer.cornerRadius = chooseCityHeight/2
        return text
    }()

    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#C2C2C2")
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        return button
    }()

    private let type: ControllerWithHeaderType
    private let chooseCityHeight: CGFloat = 44
    private weak var delegate: MainHeaderViewDelegate?

    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "miniLogo")
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sf32Font.withSize(20)
        label.textColor = UIColor(hex: "#846340")
        label.textAlignment = .center
        return label
    }()

    init(type: ControllerWithHeaderType, delegate: MainHeaderViewDelegate) {
        self.delegate = delegate
        self.type = type
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "#FAF9F9")
        configureChooseCity()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupGeo(cityModel: CityModel, countryName: String) {
        chooseCity.text = "\(countryName), \(cityModel.name)"
    }

    func updateTitle(title: String) {
        titleLabel.text = title
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        switch type {
        case .withChooseCity:
            let convertedPoint = chooseCity.convert(point, from: self)
            return chooseCity.point(inside: convertedPoint, with: event)
        default:
            return true
        }
    }

    private func setupUI() {
        setupBottomView()
        setupLogo()
        switch type {
        case .withChooseCity:
            setupChooseCity()
        case .withoutChooseCity:
            break
        case .withTitle(let title, let backButton):
            titleLabel.text = title
            setupTitle()
            logoIsHidden = true
            configureBackButton(type: backButton)
        case .withoutBackgroundColor:
            logoImage.image = UIImage(named: "miniLogoYellow")
            backgroundColor = .clear
        }
    }

    private func configureBackButton(type: HeaderBackButton) {
        backButton.isHidden = false
        switch type {
        case .none:
            backButton.isHidden = true
        case .backArrowBlack:
            backButton.setImage(UIImage(named: "backArrowBlack"), for: .normal)
        case .crossWhite:
            backButton.setImage(UIImage(named: "crossWhite"), for: .normal)
        }
        setupBackButton()
    }

    private func setupLogo() {
        addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
            switch type {
            case .withTitle, .withoutChooseCity:
                make.bottom.equalToSuperview().offset(-15)
            case .withChooseCity:
                break
            case .withoutBackgroundColor:
                make.bottom.equalToSuperview().offset(-15)
            }
        }
    }

    private func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
    }

    private func setupBottomView() {
        addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }

    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setupChooseCity() {
        addSubview(chooseCity)
        chooseCity.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(11)
            make.height.equalTo(chooseCityHeight)
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-11)
            make.bottom.equalToSuperview().offset(chooseCityHeight/2)
        }
    }

    private func configureChooseCity() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: chooseCityHeight))
        let rightView = UIView()
        let imageView = UIImageView()
        let tapGesture = UITapGestureRecognizer()
        imageView.image = UIImage(named: "backArrowWhite") //Asset.geoPoint
        rightView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-18)
        }
        chooseCity.leftView = leftView
        chooseCity.leftViewMode = .always
        chooseCity.rightView = rightView
        chooseCity.rightViewMode = .always
        chooseCity.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(tapOnChooseCity))
    }

    @objc private func tapOnChooseCity() {
        delegate?.tapOnChooseCity()
    }

    @objc private func tapBackButton() {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
            self.backButton.alpha = 0.7
        } completion: { _ in
            self.backButton.alpha = 1
            self.delegate?.tapOnBackButton()
        }
    }
}

