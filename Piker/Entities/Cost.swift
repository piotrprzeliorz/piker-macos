//
//  Cost.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Cost {

    enum CostType: String, Equatable {
        case total = "@@"
        case perUnit = "@"
    }

    let type: CostType
    let amount: Amount
}

// MARK: - Equatable

extension Cost: Equatable {

    static func ==(lhs: Cost, rhs: Cost) -> Bool {
        return lhs.type == rhs.type && lhs.amount == rhs.amount
    }
}

// MARK: - CustomStringConvertible

extension Cost: CustomStringConvertible {
    
    var description: String {
        return "\(type.rawValue) \(amount)"
    }
}
