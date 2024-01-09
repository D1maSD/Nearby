//
//  RegisterModuleContract.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewRegisterModuleProtocol {
    func showAlert(error type: TypesOfAlert)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterRegisterModuleProtocol {
    
    var view: PresenterToViewRegisterModuleProtocol? { get set }
    var interactor: PresenterToInteractorRegisterModuleProtocol? { get set }
    var router: PresenterToRouterRegisterModuleProtocol? { get set }

    func signInTapped()

    func signUp(
        emailField: String,
        passwordField: String,
        confirmField: String
    )
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorRegisterModuleProtocol {
    
    var presenter: InteractorToPresenterRegisterModuleProtocol? { get set }
    func createAccount(
        email: String,
        password: String,
        confirmPassword: String
    )
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterRegisterModuleProtocol {
    //iteractor returns a response to createAcc func
    func didRecieve(result: Result<Void, Error>)
    func didCreateAccount(with Login: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterRegisterModuleProtocol {
    func openAuthScreen()
    func showAlert(error type: TypesOfAlert)
    func presentNearestPlaces()
}
