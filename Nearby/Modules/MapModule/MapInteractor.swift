//
//  MapInteractor.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 02.01.2024.
//  
//

import MapKit

final class MapInteractor: PresenterToInteractorMapProtocol {
    typealias MapArray = MKAnnotation

    // MARK: Properties
    var presenter: InteractorToPresenterMapProtocol?
    var places: [MKAnnotation]?
    var locations: [Location] = []
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
