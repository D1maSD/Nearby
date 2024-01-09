//
//  LoginModuleContract.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewLoginModuleProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLoginModuleProtocol {
    
    var view: PresenterToViewLoginModuleProtocol? { get set }
    var interactor: PresenterToInteractorLoginModuleProtocol? { get set }
    var router: PresenterToRouterLoginModuleProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginModuleProtocol {
    
    var presenter: InteractorToPresenterLoginModuleProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginModuleProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLoginModuleProtocol {
    
}
