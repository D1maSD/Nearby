//
//  OrderCell.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.01.2024.
//

import UIKit
import SnapKit


protocol OrderCellDelegate: AnyObject {
    func plusButtonTapped(for cell: OrderCell, value: Int)
    func minusButtonTapped(for cell: OrderCell, value: Int)
}

final class OrderCell: Cell {

    weak var delegate: OrderCellDelegate?
    private var roundedContentView = UIView()

    private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusBlack"), for: .normal)
        return button
    }()
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minusBlack"), for: .normal)
        return button
    }()
    var valueTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#846340")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.regular16Font
        label.textAlignment = .center
        return label
    }()
    var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#846340")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.semibold18Font
        label.text = "Эспрессо"
        label.textAlignment = .left
        return label
    }()
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#846340")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.light16Font
        label.text = "200 руб"
        label.textAlignment = .left
        return label
    }()

    var value: Int = 0 {
        didSet {
            valueTitle.text = "\(value)"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
        addShadowToCell()
    }

    @objc func plusButtonTapped() {
        value += 1
        delegate?.plusButtonTapped(for: self, value: value)
    }

    @objc func minusButtonTapped() {
        value -= 1
            delegate?.minusButtonTapped(for: self, value: value)
    }

    private func setupUI() {
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        valueTitle.text = "\(value)"

        roundedContentView.layer.cornerRadius = 8
        roundedContentView.backgroundColor = UIColor(hex: "#F6E5D1")

        contentView.addSubview(roundedContentView)

        roundedContentView.addSubview(minusButton)
        roundedContentView.addSubview(plusButton)
        roundedContentView.addSubview(valueTitle)
        roundedContentView.addSubview(title)
        roundedContentView.addSubview(priceLabel)
    }

    private func setupLayout() {
        roundedContentView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.height.equalTo(self.frame.width - 240)
        }

        minusButton.snp.makeConstraints {
            $0.right.equalTo(roundedContentView.snp.right).offset(-80)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
            $0.centerY.equalTo(roundedContentView.snp.centerY)
        }
        plusButton.snp.makeConstraints {
            $0.right.equalTo(roundedContentView.snp.right).offset(-18)
            $0.centerY.equalTo(minusButton.snp.centerY)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        valueTitle.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right).offset(3)
            make.right.equalTo(plusButton.snp.left).offset(-3)
            make.centerY.equalTo(minusButton.snp.centerY)
        }
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
    }

    private func addShadowToCell() {
        roundedContentView.layer.masksToBounds = false
            roundedContentView.layer.shadowColor = UIColor.black.cgColor
            roundedContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            roundedContentView.layer.shadowOpacity = 0.5
            roundedContentView.layer.shadowRadius = 1

        roundedContentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0.5, y: 0, width: CGFloat(UIScreen.main.bounds.width - 25), height: CGFloat(self.frame.width - 240)), cornerRadius: 8).cgPath
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
