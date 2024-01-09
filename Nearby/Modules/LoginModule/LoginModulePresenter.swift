//
//  LoginModulePresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation

class LoginModulePresenter: ViewToPresenterLoginModuleProtocol {

    // MARK: Properties
    var view: PresenterToViewLoginModuleProtocol?
    var interactor: PresenterToInteractorLoginModuleProtocol?
    var router: PresenterToRouterLoginModuleProtocol?
}

extension LoginModulePresenter: InteractorToPresenterLoginModuleProtocol {
    
}
