//
//  MenuRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//  
//

import Foundation
import UIKit

class MenuRouter: PresenterToRouterMenuProtocol {

    weak var viewController: UIViewController?
    
    // MARK: Static methods
    static func createModule(id: Int) -> BaseViewController {

        let collectionManager = MainCollectionManager()
        var presenter: ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol = MenuPresenter()
        presenter.id = id
        let viewController = MenuViewController(collectionManager: collectionManager)
        let router = MenuRouter()
        
        print(" createModule presenter.id  \(presenter.id)")
        viewController.presenter = presenter
//        viewController.presenter?.id = id
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MenuInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.setupUI()
        router.viewController = viewController
        
        return viewController
    }

    func presentWithItems(items: [MenuItemOrder]) {
        viewController?.navigationController?.pushViewController(
            YourOrderRouter.createModule(items: items),
            animated: true
        )
    }

    func backButtonTapped() {
        viewController?.dismiss(animated: true) { [weak self] in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
