//
//  MapPresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 02.01.2024.
//  
//

import Foundation

final class MapPresenter: ViewToPresenterMapProtocol {

    // MARK: Properties
    var view: PresenterToViewMapProtocol?
    var interactor: PresenterToInteractorMapProtocol?
    var router: PresenterToRouterMapProtocol?

    func presentAboutPlaceScreen(_ object: Objects, with places: IndexPath) {
        guard let view = view else {
            return }
    }
    func backButtonTapped() {
        router?.backButtonTapped()
    }
    func getItems(completion: @escaping ([Location]) -> Void) {
        interactor?.getItems { locations in
            completion(locations)
        }
    }
}

extension MapPresenter: InteractorToPresenterMapProtocol {
    
}
