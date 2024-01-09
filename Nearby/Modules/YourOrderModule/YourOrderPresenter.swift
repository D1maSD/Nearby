//
//  YourOrderPresenter.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 04.01.2024.
//  
//


class YourOrderPresenter: ViewToPresenterYourOrderProtocol {

    // MARK: Properties
    var view: PresenterToViewYourOrderProtocol?
    var interactor: PresenterToInteractorYourOrderProtocol?
    var router: PresenterToRouterYourOrderProtocol?
    var cellCount: Int? = 5

    func numberOfRowsInSection() -> Int {
        guard let newsNubers = self.cellCount else {
            return 0
        }
        return newsNubers
    }

    func didSelectRowAt(index: Int) {
    }

    func deselectRowAt(index: Int) {
    }

    func backButtonTapped() {
        router?.backButtonTapped()
    }
}

extension YourOrderPresenter: InteractorToPresenterYourOrderProtocol {
    
}
