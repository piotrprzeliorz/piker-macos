//
//  Value.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum Value {
    case amount(Amount)
    case string(String)
    case regex(String)
    case bool(Bool)
    case date(EvaluatedDate)
}

extension Value {

    func op(double f: (LedgerDouble, LedgerDouble) -> LedgerDouble, _ other: Value) throws -> Amount {
        guard case .amount(let selfAmount) = self, case .amount(let otherAmount) = other else { throw GenericError.unknown }
        return try selfAmount.op(f, otherAmount)
    }

    func op(bool f: (Bool, Bool) -> Bool, _ other: Value) throws -> Bool {
        guard case .bool(let selfValue) = self, case .bool(let otherValue) = other else { throw GenericError.unknown }
        return f(selfValue, otherValue)
    }

    func matches(_ rhs: Value) throws -> Bool {
        guard case let .regex(regex) = rhs, let string = stringRepresentation else { throw GenericError.unknown }
        let range = NSRange(location: 0, length: (string as NSString).length)
        return try NSRegularExpression(pattern: regex, options: []).firstMatch(in: string, options: [], range: range) != nil
    }

    var stringRepresentation: String? {
        switch self {
        case .string(let string):
            return string
        case .date(let date):
            return date.string
        default:
            return nil
        }
    }
}

// MARK: - Equatable

extension Value: Equatable {

    static func ==(lhs: Value, rhs: Value) -> Bool {
        switch (lhs,rhs) {
        case let (.amount(x), .amount(y)):
            return x == y
        case let (.string(x), .string(y)):
            return x == y
        case let (.regex(x), .regex(y)):
            return x == y
        case let (.bool(x), .bool(y)):
            return x == y
        case let (.date(x), .date(y)):
            return x == y
        default:
            return false
        }
    }
}


