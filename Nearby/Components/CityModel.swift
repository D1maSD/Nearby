//
//  CityModel.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 01.01.2024.
//

public struct CityModel {
    public let name: String
    public let id: String
    public let description: String

    public init() {
        name = "default"
        id = ""
        description = "default"
    }

    public init(name: String) {
        self.name = name
        self.id = ""
        self.description = ""
    }

    public init(name: String, id: String, description: String) {
        self.name = name
        self.id = id
        self.description = description
    }
}
