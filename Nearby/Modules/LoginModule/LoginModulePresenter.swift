//
//  LoginModulePresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation

final class LoginModulePresenter: ViewToPresenterLoginModuleProtocol {

    func signIn(emailField: String, passwordField: String) {
        interactor?.signIn(email: emailField, password: passwordField)
    }


    // MARK: Properties
    var view: PresenterToViewLoginModuleProtocol?
    var interactor: PresenterToInteractorLoginModuleProtocol?
    var router: PresenterToRouterLoginModuleProtocol?
}

extension LoginModulePresenter: InteractorToPresenterLoginModuleProtocol {
    func didRecieve(result: Result<Void, Error>) {
        switch result {
            case .success(_):
            router?.presentNearestPlaces()

            case .failure(let failure):
            print("Не удалось войти в аккаунт: \(failure.localizedDescription)")
            }
    }
}
