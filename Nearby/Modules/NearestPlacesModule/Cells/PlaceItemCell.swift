//
//  PlaceItemCell.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 30.12.2023.
//

import UIKit
import SnapKit


final class PlaceItemCell: Cell {

    private var roundedContentView = UIImageView()

    var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#846340")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.semibold18Font
        label.text = "BEDOEV COFFE"
        label.textAlignment = .left
        return label
    }()
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#AF9479")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.light16Font
        label.text = "2 км от вас"
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupTitle()
        addShadowToCell()
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
    }

    private func addShadowToCell() {
        roundedContentView.layer.masksToBounds = false
            roundedContentView.layer.shadowColor = UIColor.black.cgColor
            roundedContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            roundedContentView.layer.shadowOpacity = 0.5
            roundedContentView.layer.shadowRadius = 1

        roundedContentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0.5, y: 0, width: CGFloat(UIScreen.main.bounds.width - 25), height: CGFloat(self.frame.width - 240)), cornerRadius: 8).cgPath
    }

    private func setupLayout() {

        roundedContentView.backgroundColor = UIColor(hex: "#F6E5D1")
        roundedContentView.layer.cornerRadius = 8

        contentView.addSubview(roundedContentView)
        roundedContentView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.height.equalTo(self.frame.width - 240)
        }
    }

    private func setupTitle() {
        roundedContentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }

        roundedContentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


