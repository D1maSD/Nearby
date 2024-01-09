//
//  Enums.swift
//  Nearby
//
//  Created by Мельник Дмитрий on 12.12.2022.
//

import Foundation


enum Flow {
    case mapKitFlow
    case playerFlow
    case sheduleKitFlow
    case newsFlow
    case booksFlow
}

enum TypesOfAlert {
    case emptyFields
    case emptyNameAndJob
    case accountExists
    case accountNotFound
    case regSuccessful
    case passwordsNotMuch
    case registrationFailed
    case randomSystemError
    case passwordError
    case emailError
    case emailOrPasswordError
    case loginExists
    case emailExists
    case titleIsEmpty
}

enum Annotations {
    case Lunacharskiy
    case Musson
}

enum TypeOfPicker {
    case date
    case age
    case gender
}

enum SheduleScreens {
    case note
    case contacts
    case profile
    case shedule
}

enum Objects {
    case lunacharskiy
    case musson
    case malachovHill
    case submergedShips
    case chersonesTavr
    case panorama
    case cementary
    case sevSU
    case omega
    case seaMall
}
