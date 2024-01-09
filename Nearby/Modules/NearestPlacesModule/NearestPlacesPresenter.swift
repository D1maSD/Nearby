//
//  NearestPlacesPresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 3.01.2024.
//  
//


class NearestPlacesPresenter: ViewToPresenterNearestPlacesProtocol {

    // MARK: Properties
    var view: PresenterToViewNearestPlacesProtocol?
    var interactor: PresenterToInteractorNearestPlacesProtocol?
    var router: PresenterToRouterNearestPlacesProtocol?
    var locations: [Location] = []

    func numberOfRowsInSection(completion: @escaping (Int) -> Void) {
        interactor?.numberOfRowsInSection { count in
            completion(count)
        }
    }

    func getItems(completion: @escaping ([Location]) -> Void) {
        interactor?.getItems { locations in
            completion(locations)
        }
    }

    func presentWithId(id: Int) {
        router?.presentWithId(id: id)
    }
    func backButtonTapped() {
        router?.backButtonTapped()
    }
    func onMapTapped() {
        router?.onMapTapped()
    }
}

extension NearestPlacesPresenter: InteractorToPresenterNearestPlacesProtocol {
    
}
