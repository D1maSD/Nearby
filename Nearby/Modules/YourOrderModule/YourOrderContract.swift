//
//  YourOrderContract.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.01.2024.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewYourOrderProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterYourOrderProtocol {
    
    var view: PresenterToViewYourOrderProtocol? { get set }
    var interactor: PresenterToInteractorYourOrderProtocol? { get set }
    var router: PresenterToRouterYourOrderProtocol? { get set }

    func numberOfRowsInSection() -> Int
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)
    func backButtonTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorYourOrderProtocol {
    
    var presenter: InteractorToPresenterYourOrderProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterYourOrderProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterYourOrderProtocol {
    func presentFlow(view: UIViewController, flow: Flow)
    func backButtonTapped()
}
