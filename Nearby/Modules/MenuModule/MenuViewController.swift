//
//  MenuViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//
//

import UIKit

class MenuViewController: BaseCollectionViewController {


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
        var array = [CategoryModel(id: 1, title: "1"), CategoryModel(id: 2, title: "2"), CategoryModel(id: 3, title: "3"),CategoryModel(id: 4, title: "4"),CategoryModel(id: 5, title: "5"),CategoryModel(id: 6, title: "6")]
        let configurators = array.map { MainCategoriesCollectionConfigurator(model: $0) }
        collectionManager?.update(configurators: configurators)
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
        print("item: \(item) value: \(value)")
//        let newItem = MenuItemOrder(item: item, value: value)
//        orderItems.append(newItem)
        if let existingIndex = orderItems.firstIndex(where: { $0.item.id == item.id }) {
                // Уже есть выбранный пункт меню, обновляем его значение
                orderItems[existingIndex].value = value
            } else {
                // Этот пункт меню ещё не был выбран, добавляем его в заказ
                orderItems.append(MenuItemOrder(item: item, value: value))
            }
    }
}

struct MenuItemOrder {
    let item: MenuItem
    var value: Int
}

