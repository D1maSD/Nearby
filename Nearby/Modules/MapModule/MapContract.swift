//
//  MapContract.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 02.01.2024.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMapProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMapProtocol {
    
    var view: PresenterToViewMapProtocol? { get set }
    var interactor: PresenterToInteractorMapProtocol? { get set }
    var router: PresenterToRouterMapProtocol? { get set }

    func presentAboutPlaceScreen(_ object: Objects, with places: IndexPath)
    func backButtonTapped()
    func getItems(completion: @escaping ([Location]) -> Void)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMapProtocol {
    
    var presenter: InteractorToPresenterMapProtocol? { get set }
    func getItems(completion: @escaping ([Location]) -> Void)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMapProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMapProtocol {
    func backButtonTapped()
}
