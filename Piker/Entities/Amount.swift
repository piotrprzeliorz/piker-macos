//
//  Amount.swift
//  Piker
//
//  Created by Piotr Przeliorz on 18/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Amount {

    var number: LedgerDouble
    var commodity: Commodity

    var hasCommodity: Bool {
        return commodity.value != nil
    }

    var isNegative: Bool {
        return number.isNegative
    }

    init(_ number: LedgerDouble, commodity: Commodity = Commodity()) {
        self.number = number
        self.commodity = commodity
    }

    func matchingSign(ofAmount otherAmount: Amount) -> Amount {
        guard isNegative != otherAmount.isNegative else { return self }
        return Amount(number * -1, commodity: commodity)
    }

    func op(_ f: (LedgerDouble, LedgerDouble) -> LedgerDouble, _ other: Amount) throws -> Amount {
        let commodity = try self.commodity.unify(other.commodity)
        return Amount(f(self.number, other.number), commodity: commodity)
    }
}

// MARK: - Equatable

extension Amount: Equatable {

    static func ==(lhs: Amount, rhs: Amount) -> Bool {
        return lhs.commodity == rhs.commodity && lhs.number == rhs.number
    }
}


// MARK: - CustomStringConvertible

extension Amount: CustomStringConvertible {

    var description: String {
        return "\(number.value)\(commodity)"
    }
}



