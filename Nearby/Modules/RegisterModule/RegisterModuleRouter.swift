//
//  RegisterModuleRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation
import UIKit

final class RegisterModuleRouter: PresenterToRouterRegisterModuleProtocol {

    weak var rootViewController: UIViewController?
    var loginRouter = LoginModuleRouter()

    weak var viewController: UIViewController?
    
    // MARK: Static methods
    static func createModule() -> BaseViewController {
        
        let viewController = RegisterModuleViewController()
        let router = RegisterModuleRouter()
        
        let presenter: ViewToPresenterRegisterModuleProtocol & InteractorToPresenterRegisterModuleProtocol = RegisterModulePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = RegisterModuleInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }

    func closeCurrentViewController() {
        viewController?.dismiss(animated: true, completion: nil)
    }

    func presentNearestPlaces() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.navigationController?.pushViewController(NearestPlacesRouter.createModule(), animated: true)
        }
    }

    func openAuthScreen() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.navigationController?.pushViewController(LoginModuleRouter.createModule(), animated: true)
        }
    }

    func showAlert(error type: TypesOfAlert) {

    }
}
