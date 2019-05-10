//
//  LedgerDouble.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct LedgerDouble {

    var value: Double
    var isNegative: Bool {
        return 0 > value
    }

    init(_ value: Double) {
        self.value = value
    }

    init(_ value: Int) {
        self.value = Double(value)
    }

    init?(_ string: String) {
        guard let value = Double(string) else { return nil }
        self.value = value
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension LedgerDouble: ExpressibleByIntegerLiteral {

    init(integerLiteral value: Double) {
        self.value = value
    }
}

// MARK: - ExpressibleByFloatLiteral

extension LedgerDouble: ExpressibleByFloatLiteral {

    init(floatLiteral value: Double) {
        self.value = value
    }
}

// MARK: - Equatable

extension LedgerDouble: Equatable {

    static func ==(lhs: LedgerDouble, rhs: LedgerDouble) -> Bool {
        if rhs.value == 0 {
            return abs(lhs.value) < 0.000000001
        }
        return lhs.value == rhs.value
    }
}

func +(lhs: LedgerDouble, rhs: LedgerDouble) -> LedgerDouble {
    return LedgerDouble(lhs.value + rhs.value)
}
func -(lhs: LedgerDouble, rhs: LedgerDouble) -> LedgerDouble {
    return LedgerDouble(lhs.value - rhs.value)
}
func *(lhs: LedgerDouble, rhs: LedgerDouble) -> LedgerDouble {
    return LedgerDouble(lhs.value * rhs.value)
}
func /(lhs: LedgerDouble, rhs: LedgerDouble) -> LedgerDouble {
    return LedgerDouble(lhs.value / rhs.value)
}

prefix func -(lhs: LedgerDouble) -> LedgerDouble {
    return LedgerDouble(-lhs.value)
}

func +=(lhs: inout LedgerDouble, rhs: LedgerDouble) {
    lhs.value += rhs.value
}

func *=(lhs: inout LedgerDouble, rhs: LedgerDouble) {
    lhs.value *= rhs.value
}
