//
//  RegisterModuleInteractor.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation

class RegisterModuleInteractor: PresenterToInteractorRegisterModuleProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterRegisterModuleProtocol?

    func createAccount(
        email: String,
        password: String,
        confirmPassword: String
    ) {

        AuthService.shared.registerButtonPressed(email: email, password: password, completion: { [weak self] result in
            self?.presenter?.didRecieve(result: result)
        })
    }
}
