//
//  NearestPlacesInteractor.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 3.01.2024.
//  
//

import Foundation

class NearestPlacesInteractor: PresenterToInteractorNearestPlacesProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterNearestPlacesProtocol?
    var locations: [Location] = []
    func numberOfRowsInSection() -> Int {
        locations = AuthService.shared.getLocations()
        return locations.count
    }

    func getItems() -> [Location] {
        locations = AuthService.shared.getLocations()
        return locations
    }
}
