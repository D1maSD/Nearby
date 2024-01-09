//
//  MapInteractor.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 02.01.2024.
//  
//

import MapKit

class MapInteractor: PresenterToInteractorMapProtocol {
    typealias MapArray = MKAnnotation

    // MARK: Properties
    var presenter: InteractorToPresenterMapProtocol?
    var places: [MKAnnotation]?
}
