//
//  LoginModuleRouter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation
import UIKit

class LoginModuleRouter: PresenterToRouterLoginModuleProtocol {
    weak var viewController: UIViewController?
    // MARK: Static methods
    static func createModule() -> BaseViewController {
        
        let viewController = LoginModuleViewController()
        let router = LoginModuleRouter()
        
        let presenter: ViewToPresenterLoginModuleProtocol & InteractorToPresenterLoginModuleProtocol = LoginModulePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LoginModuleInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
    
}
