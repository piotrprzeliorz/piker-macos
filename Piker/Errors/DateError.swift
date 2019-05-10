//
//  DateError.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum DateError: Error {
    case year
}

// MARK: - LocalizedError

extension DateError: LocalizedError {

    var errorDescription: String? {
        switch  self {
        case .year:
            return Localizable.noYear
        }
    }
}

