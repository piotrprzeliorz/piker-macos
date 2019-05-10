//
//  GenericError.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum GenericError: Error {
    case unknown
    case data
}

// MARK: - LocalizedError

extension GenericError: LocalizedError {

    var errorDescription: String? {
        switch  self {
        case .unknown:
            return Localizable.somethingWentWrong
        case .data:
            return Localizable.couldntReadData
        }
    }
}

