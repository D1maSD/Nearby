//
//  RegisterModulePresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation

class RegisterModulePresenter: ViewToPresenterRegisterModuleProtocol {

    // MARK: Properties
    var view: PresenterToViewRegisterModuleProtocol?
    var interactor: PresenterToInteractorRegisterModuleProtocol?
    var router: PresenterToRouterRegisterModuleProtocol?
}

extension RegisterModulePresenter: PresenterToViewRegisterModuleProtocol {
    func showAlert(error type: TypesOfAlert) {
    }

    func signUp(
        emailField: String,
        passwordField: String,
        confirmField: String
    ) {
        interactor?.createAccount(email: emailField, password: passwordField, confirmPassword: confirmField)
    }
    func signInTapped() {
        router?.openAuthScreen()
    }
}

extension RegisterModulePresenter: InteractorToPresenterRegisterModuleProtocol {
    func didRecieve(result: Result<Void, Error>) {
        switch result {
            case .success(_):
            router?.presentNearestPlaces()

            case .failure(let failure):
            print("Не удалось создать аккаунт: \(failure.localizedDescription)")
            }
    }

    func didCreateAccount(with Login: String) {
        view?.showAlert(error: .regSuccessful)
    }
}

