//
//  LoginModuleInteractor.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 31.12.2023.
//  
//

import Foundation

final class LoginModuleInteractor: PresenterToInteractorLoginModuleProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterLoginModuleProtocol?

    func signIn(email: String, password: String) {
        AuthService.shared.loginButtonPressed(email, password, completion:{ [weak self] result in
            self?.presenter?.didRecieve(result: result)
        })
    }
}
