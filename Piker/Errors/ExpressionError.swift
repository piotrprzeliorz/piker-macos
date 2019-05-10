//
//  ExpressionError.swift
//  Piker
//
//  Created by Piotr Przeliorz on 18/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum ExpressionError: Error {
    case commoditiesError
    case undefinedOperator
    case unknownVariable
    case transactionBalance
    case transactionWithoutAmount
    case posting
}

// MARK: - LocalizedError

extension ExpressionError: LocalizedError {

    var errorDescription: String? {
        switch  self {
        case .commoditiesError:
            return Localizable.commoditiesError
        case .undefinedOperator:
            return Localizable.undefinedOperator
        case .unknownVariable:
            return Localizable.unknownVariable
        case .transactionBalance:
            return Localizable.transactionBalance
        case .transactionWithoutAmount:
            return Localizable.transactionWithoutAmount
        case .posting:
            return Localizable.postingNonAmount
        }
    }

}
