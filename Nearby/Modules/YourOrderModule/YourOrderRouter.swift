//
//  YourOrderRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.01.2024.
//  
//

import Foundation
import UIKit

class YourOrderRouter: PresenterToRouterYourOrderProtocol {

    weak var viewController: UIViewController?
    
    // MARK: Static methods
//    static func createModule() -> BaseViewController {
//        
//        let viewController = YourOrderViewController()
//        
//        let presenter: ViewToPresenterYourOrderProtocol & InteractorToPresenterYourOrderProtocol = YourOrderPresenter()
//        
//        viewController.presenter = presenter
//        viewController.presenter?.router = YourOrderRouter()
//        viewController.presenter?.view = viewController
//        viewController.presenter?.interactor = YourOrderInteractor()
//        viewController.presenter?.interactor?.presenter = presenter
//        
//        return viewController
//    }

    static func createModule(items: [MenuItemOrder]) -> BaseViewController {

        print("YourOrderRouter createModule items:  \(items)")
        let viewController = YourOrderViewController(items: items)

        let presenter: ViewToPresenterYourOrderProtocol & InteractorToPresenterYourOrderProtocol = YourOrderPresenter()

        let router = YourOrderRouter()

//        viewController.items = items
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = YourOrderInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        router.viewController = viewController

        return viewController
    }

    func presentFlow(view: UIViewController, flow: Flow) {
        
    }

    func backButtonTapped() {
        viewController?.dismiss(animated: true) { [weak self] in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
