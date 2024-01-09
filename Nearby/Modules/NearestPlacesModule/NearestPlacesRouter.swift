//
//  NearestPlacesRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 3.01.2024.
//  
//

import Foundation
import UIKit

class NearestPlacesRouter: PresenterToRouterNearestPlacesProtocol {

    weak var viewController: UIViewController?
    // MARK: Static methods
    private weak var navigationController: CustomNavigationController?
    static func createModule() -> UIViewController {
        
        let viewController = NearestPlacesViewController()
        let router = NearestPlacesRouter()
        
        let presenter: ViewToPresenterNearestPlacesProtocol & InteractorToPresenterNearestPlacesProtocol = NearestPlacesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = NearestPlacesInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }

    func presentWithId(id: Int) {
        viewController?.navigationController?.pushViewController(
                MenuRouter.createModule(id: id),
                animated: true
            )
    }
    func backButtonTapped() {
        viewController?.dismiss(animated: true) { [weak self] in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
    }

    func onMapTapped() { 
        viewController?.navigationController?.pushViewController(MapRouter.createModule(), animated: true)
    }
}
