//
//  MenuViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//
//

import UIKit

final class MenuViewController: BaseCollectionViewController {


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentButton.setTitle("Перейти к оплате", for: .normal)
        paymentButton.addTarget(self, action: #selector(onPaymentTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCatigories()
    }

    private func getCatigories() {
        
    }

    override init(collectionManager: MainCollectionManagment) {
        super.init(collectionManager: collectionManager)
        collectionManager.delegate = self
        collectionManager.id = presenter?.id ?? 0
        bindBackTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        collectionManager?.attach(collection, id: presenter?.id ?? 0)
        setupCollection()
    }

    @objc func onPaymentTapped() {
        presenter?.presentWithItems(items: orderItems)
    }

    private func bindBackTap() {
        backButtonTap = {
            self.presenter?.backButtonTapped()
        }
    }

    private func setupCollection() {
        contentView.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(19)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        contentView.addSubview(paymentButton)
        paymentButton.snp.makeConstraints {
            $0.left.equalTo(contentView.snp.left).offset(25)
            $0.right.equalTo(contentView.snp.right).offset(-25)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-30)
            $0.height.equalTo(52)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMenuProtocol?
    private var collection = CollectionViewFactory.make()
    private var paymentButton = UIButton(style: .sighUpButtonStyle)

    var menuItems: [MenuItem] = []
    var orderItems: [MenuItemOrder] = []

}

extension MenuViewController: PresenterToViewMenuProtocol {
    // TODO: Implement View Output Methods
}

extension MenuViewController: MainCollectionManagerDelegate {
    func selectCell(category: CategoryModel) {
        print("selectCell")
    }


    func selectCell(item: MenuItem, value: Int) {

        if let existingIndex = orderItems.firstIndex(where: { $0.item.id == item.id }) {
                orderItems[existingIndex].value = value
            } else {
                orderItems.append(MenuItemOrder(item: item, value: value))
            }
    }
}

struct MenuItemOrder {
    let item: MenuItem
    var value: Int
}


