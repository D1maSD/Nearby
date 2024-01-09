//
//  BaseCollectionViewController.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//

import UIKit

class BaseCollectionViewController: BaseControllerWithHeader {

    internal let collectionManager: MainCollectionManagment?

    init(collectionManager: MainCollectionManagment) {
        self.collectionManager = collectionManager
        super.init(type: .withTitle(title: "Меню", backButton: .backArrowBlack))
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
