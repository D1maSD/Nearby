//
//  NearestPlacesContract.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 3.01.2024.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewNearestPlacesProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterNearestPlacesProtocol {
    
    var view: PresenterToViewNearestPlacesProtocol? { get set }
    var interactor: PresenterToInteractorNearestPlacesProtocol? { get set }
    var router: PresenterToRouterNearestPlacesProtocol? { get set }
    var locations: [Location] { get set }

    func numberOfRowsInSection(completion: @escaping (Int) -> Void)
    func presentWithId(id: Int)
    func backButtonTapped()
    func getItems(completion: @escaping ([Location]) -> Void)
    func onMapTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorNearestPlacesProtocol {
    
    var presenter: InteractorToPresenterNearestPlacesProtocol? { get set }
    func numberOfRowsInSection(completion: @escaping (Int) -> Void)
    func getItems(completion: @escaping ([Location]) -> Void)
    
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterNearestPlacesProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterNearestPlacesProtocol {
    func presentWithId(id: Int)
    func backButtonTapped()
    func onMapTapped()
}
