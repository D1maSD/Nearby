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

    func signIn(emailField: String, passwordField: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginModuleProtocol {
    
    var presenter: InteractorToPresenterLoginModuleProtocol? { get set }
    func signIn(email: String, password: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginModuleProtocol {
    func didRecieve(result: Result<Void, Error>)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLoginModuleProtocol {
    func presentNearestPlaces()
}
