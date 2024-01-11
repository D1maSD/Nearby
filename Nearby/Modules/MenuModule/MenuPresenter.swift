//
//  MenuPresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//  
//

import Foundation

final class MenuPresenter: ViewToPresenterMenuProtocol {

    // MARK: Properties
    var view: PresenterToViewMenuProtocol?
    var interactor: PresenterToInteractorMenuProtocol?
    var router: PresenterToRouterMenuProtocol?
    var id = Int()
    func presentWithItems(items: [MenuItemOrder]) {
        router?.presentWithItems(items: items)
    }
    func backButtonTapped() {
        router?.backButtonTapped()
    }
}

extension MenuPresenter: InteractorToPresenterMenuProtocol {
    
}
