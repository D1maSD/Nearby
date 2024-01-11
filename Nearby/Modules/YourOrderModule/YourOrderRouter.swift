//
//  YourOrderRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.01.2024.
//  
//

import Foundation
import UIKit

final class YourOrderRouter: PresenterToRouterYourOrderProtocol {

    weak var viewController: UIViewController?
    
    // MARK: Static methods
    static func createModule(items: [MenuItemOrder]) -> BaseViewController {

        print("YourOrderRouter createModule items:  \(items)")
        let viewController = YourOrderViewController(items: items)

        let presenter: ViewToPresenterYourOrderProtocol & InteractorToPresenterYourOrderProtocol = YourOrderPresenter()

        let router = YourOrderRouter()

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
