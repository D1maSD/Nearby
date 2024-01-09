//
//  YourOrderViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.01.2024.
//  
//

import UIKit


class YourOrderViewController: BaseControllerWithHeader {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        payButton = UIButton(style: .sighUpButtonStyle)
        payButton.setTitle("Оплатить", for: .normal)

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.logoTitleFont,
        ]
        setup()
        payButton.addTarget(self, action: #selector(onPayTapped), for: .touchUpInside)
    }

    init(items: [MenuItemOrder]) {
        self.items = items
        super.init(type: .withTitle(title: "Ваш заказ", backButton: .backArrowBlack))
        bindBackTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var payButton = UIButton()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    // MARK: - Properties
    var presenter: ViewToPresenterYourOrderProtocol?
    var items: [MenuItemOrder] {
        didSet {
            tableView.reloadData()
        }
    }
    private var tableView = UITableView()


    private func configureTableView() {
        contentView.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: "\(OrderCell.self)")
    }

    private func bindBackTap() {
        backButtonTap = {
            self.presenter?.backButtonTapped()
        }
    }


    private func setup() {

        tableView.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left)
            $0.right.equalTo(contentView.snp.right)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.top.equalTo(contentView.snp.top).offset(52)
        }

        contentView.addSubview(payButton)
        payButton.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-40)
            $0.height.equalTo(52)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }

    // MARK: - signInTapped
    @objc func onPayTapped() {
        print("Ваш заказ")
        for item in items {
            print(" \(item.item.name) в количестве \(item.value)")
        }
        print("в обработке.")
    }
}

extension YourOrderViewController: PresenterToViewYourOrderProtocol{
    // TODO: Implement View Output Methods
}

extension YourOrderViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.value = items[indexPath.row].value
        cell.title.text = items[indexPath.row].item.name
        cell.priceLabel.text = String("\(items[indexPath.row].item.price) руб")
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension YourOrderViewController: OrderCellDelegate {

    func plusButtonTapped(for cell: OrderCell, value: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
            var menuItem = items[indexPath.row]
        items[indexPath.row].value = value
        menuItem.value = value

    }
    func minusButtonTapped(for cell: OrderCell, value: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
            var menuItem = items[indexPath.row]
        items[indexPath.row].value = value
        menuItem.value = value
    }
}


struct Location: Codable {
    let id: Int
    let name: String
    let point: Point
}

struct Point: Codable {
    let latitude: String
    let longitude: String
}


struct MenuItem: Codable {
    let id: Int
    let name: String
    let imageURL: String?
    let price: Int
}

enum NetworkError: Error {
    case tokenMissing
    case invalidURL
    case noData
}
