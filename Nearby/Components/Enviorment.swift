//
//  Enviorment.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 06.01.2024.
//

import Foundation


struct Enviorment {
    private struct Constants {
        static let yandexMapAPIKey = "a3759c40-d8b4-4985-b3b4-cd6ec228b61d"
    }

    var yandexMapApiKey: String = Constants.yandexMapAPIKey
}
struct AppModel {
    let enviorment: Enviorment
    let ymkStyle: String

    init(_ enviorment: Enviorment, style: String) {
        self.enviorment = enviorment
        self.ymkStyle = style
    }
}
