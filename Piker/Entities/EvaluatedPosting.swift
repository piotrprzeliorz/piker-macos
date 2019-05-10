//
//  EvaluatedPosting.swift
//  Piker
//
//  Created by Piotr Przeliorz on 19/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct EvaluatedPosting {

    var account: String
    var amount: Amount
    var cost: Amount?
    var virtual: Bool

    func expressionContext(name: String) -> Value? {
        switch name {
        case "account":
            return .string(self.account)
        case "commodity":
            return .string(amount.commodity.value ?? "")
        default:
            return nil
        }
    }

    func match(expression: Expression, context: @escaping ExpressionContext) throws -> Bool {
        let value = try expression.evaluate(context: expressionContext)
        guard case .bool(let result) = value else { throw GenericError.unknown }
        return result
    }

    func matches(_ search: [Filter]) -> Bool {
        return search.all(matches)
    }

    func matches(_ search: Filter) -> Bool {
        switch search {
        case .account(let name):
            return account.hasPrefix(name)
        case .string(let string):
            return account.lowercased().contains(string.lowercased()) || amount.number.value.displayFormat(commodity: amount.commodity.value).contains(string)
        case .period:
            return false
        }
    }
}

// MARK: - Equatable

extension EvaluatedPosting: Equatable {

    static func ==(lhs: EvaluatedPosting, rhs: EvaluatedPosting) -> Bool {
        return lhs.account == rhs.account && lhs.amount == rhs.amount && lhs.cost == rhs.cost && lhs.virtual == rhs.virtual
    }

}

// MARK: - CustomStringConvertible

extension EvaluatedPosting: CustomStringConvertible {

    var description: String {
        let displayCost = cost == nil ? "" : "@@ \(cost!)"
        return "\(account)  \(amount)\(displayCost)"
    }
}

