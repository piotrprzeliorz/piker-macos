//
//  Commodity.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Commodity {

    let value: String?

    init(_ value: String? = nil) {
        self.value = value
    }

    func unify(_ other: Commodity) throws -> Commodity {
        switch (value, other.value) {
        case (nil, nil):
            return Commodity()
        case (nil, _):
            return other
        case (_, nil):
            return self
        case (let c1, let c2) where c1 == c2:
            return self
        default:
            throw ExpressionError.commoditiesError
        }
    }
}

// MARK: - Equatable

extension Commodity: Equatable {

    static func ==(x: Commodity, y: Commodity) -> Bool {
        return x.value == y.value
    }
}

// MARK: - Hashable

extension Commodity: Hashable {

    var hashValue: Int {
        return value?.hashValue ?? -1
    }
}

// MARK: - CustomStringConvertible

extension Commodity: CustomStringConvertible {

    var description: String {
        return value ?? ""
    }
}
