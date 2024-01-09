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

    func numberOfRowsInSection() -> Int {
        interactor?.numberOfRowsInSection() ?? 0
    }

    func getItems() -> [Location] {
        return interactor?.getItems() ?? [Location]()
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
