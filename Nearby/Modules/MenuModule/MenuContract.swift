//
//  MenuContract.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 03.01.2024.
//  
//

import Foundation
import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMenuProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMenuProtocol {
    
    var view: PresenterToViewMenuProtocol? { get set }
    var interactor: PresenterToInteractorMenuProtocol? { get set }
    var router: PresenterToRouterMenuProtocol? { get set }
    var id: Int { get set }
    func presentWithItems(items: [MenuItemOrder])
    func backButtonTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMenuProtocol {
    
    var presenter: InteractorToPresenterMenuProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMenuProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMenuProtocol {
    func presentWithItems(items: [MenuItemOrder])
    func backButtonTapped()
}
