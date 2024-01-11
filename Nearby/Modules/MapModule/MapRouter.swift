//
//  MapRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 02.01.2024.
//  
//

import Foundation
import UIKit

final class MapRouter: PresenterToRouterMapProtocol {

    weak var viewController: UIViewController?
    
    // MARK: Static methods
    static func createModule() -> BaseViewController {
        
        let viewController = MapViewController()
        let router = MapRouter()
        
        let presenter: ViewToPresenterMapProtocol & InteractorToPresenterMapProtocol = MapPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MapInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }

    func backButtonTapped() {
        viewController?.dismiss(animated: true) { [weak self] in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
