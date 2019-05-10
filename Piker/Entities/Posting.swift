//
//  Posting.swift
//  Piker
//
//  Created by Piotr Przeliorz on 19/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Posting {

    var account: String
    var value: Expression?
    var cost: Cost?
    var balance: Amount?
    var virtual: Bool
    var notes: [Note]

    func evaluate(context: ExpressionContext) throws -> EvaluatedPosting {
        let value = try self.value!.evaluate(context: context)
        guard case .amount(let amount) = value else { throw ExpressionError.posting }
        var costAmount: Amount? = nil
        if let cost = cost {
            switch cost.type {
            case .total:
                costAmount = cost.amount.matchingSign(ofAmount: amount)
            default:
                fatalError()
            }
        }
        return EvaluatedPosting(account: account, amount: amount, cost: costAmount, virtual: virtual)
    }
}

extension Posting {

    init(account: String, amount: Amount, cost: Cost? = nil, balance: Amount? = nil, virtual: Bool = false, note: Note? = nil) {
        self = Posting(account: account, value: .amount(amount), cost: cost, balance: balance, virtual: virtual, notes: note.map { [$0] } ?? [])
    }

    init(account: String, value: Expression? = nil, cost: Cost? = nil, balance: Amount? = nil, virtual: Bool = false, note: Note? = nil) {
        self = Posting(account: account, value: value, cost: cost, balance: balance, virtual: virtual, notes: note.map { [$0] } ?? [])
    }

    init(account: (String, Bool), value: Expression? = nil, cost: Cost? = nil, balance: Amount? = nil, note: Note? = nil) {
        self = Posting(account: account.0, value: value, cost: cost, balance: balance, virtual: account.1, notes: note.map { [$0] } ?? [])
    }
}

// MARK: - Equatalbe

extension Posting: Equatable {

    static func ==(lhs: Posting, rhs: Posting) -> Bool {
        return lhs.account == rhs.account &&
            lhs.value == rhs.value &&
            lhs.cost == rhs.cost &&
            lhs.balance == rhs.balance &&
            lhs.notes == rhs.notes &&
            lhs.virtual == rhs.virtual
    }

}
