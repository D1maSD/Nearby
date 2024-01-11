//
//  NearestPlacesInteractor.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 3.01.2024.
//  
//

import Foundation

final class NearestPlacesInteractor: PresenterToInteractorNearestPlacesProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterNearestPlacesProtocol?
    var locations: [Location] = []
    var count: Int = 0
    func numberOfRowsInSection(completion: @escaping (Int) -> Void) {
        LocationService.shared.getLocations { result in
            switch result {
                case .success(let locations):
                    self.locations = locations
                    completion(locations.count)
                case .failure(let failure):
                    print("Error: \(failure)")
                    completion(0)
            }
        }
    }


    func getItems(completion: @escaping ([Location]) -> Void) {
        LocationService.shared.getLocations { result in
            switch result {
                case .success(let locations):
                    self.locations = locations
                    completion(locations)
                case .failure(let failure):
                    print("Error: \(failure)")
                    completion([Location]())
            }
        }
    }
}
