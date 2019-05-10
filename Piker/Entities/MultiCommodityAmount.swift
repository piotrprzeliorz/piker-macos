//
//  MultiCommodityAmount.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct MultiCommodityAmount {

    var value: [Commodity: LedgerDouble] = [:]
}

extension MultiCommodityAmount {

    subscript(_ key: Commodity) -> LedgerDouble {
        get {
            return value[key, or: 0]
        }
        set {
            value[key] = newValue
        }
    }
}

// MARK: - Equatable

extension MultiCommodityAmount: Equatable {

    static func ==(lhs: MultiCommodityAmount, rhs: MultiCommodityAmount) -> Bool {
        return lhs.value == rhs.value
    }
}


func +=(lhs: inout MultiCommodityAmount, rhs: MultiCommodityAmount) {
    for (commodity, value) in rhs.value {
        lhs[commodity] += value
    }
}
