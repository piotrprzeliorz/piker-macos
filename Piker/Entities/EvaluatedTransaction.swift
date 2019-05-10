//
//  EvaluatedTransaction.swift
//  Piker
//
//  Created by Piotr Przeliorz on 19/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct EvaluatedTransaction {

    let title: String
    var postings: [EvaluatedPosting]
    let date: EvaluatedDate

    var balance: [Commodity: LedgerDouble] {
        var result: [Commodity: LedgerDouble] = [:]
        for posting in postings {
            let amount = posting.cost ?? posting.amount
            result[amount.commodity, or: 0] += amount.number
        }
        return result
    }

    func verify() throws {
        if balance.count == 2 {
            let keys = Array(balance.keys)
            let firstAmount = balance[keys[0]]!
            let secondAmount = balance[keys[1]]!
            let implicitCurrencyConversion = firstAmount.isNegative != secondAmount.isNegative
            guard !implicitCurrencyConversion else { return }
        }

        for (_, value) in balance {
            guard value == 0 else { throw ExpressionError.transactionBalance}
        }
    }

    func lookup(variable: String) -> Value? {
        switch variable {
        case "date":
            return .date(date)
        default:
            return nil
        }
    }

    mutating func append(posting: Posting, context: @escaping ExpressionContext) throws {
        try postings.append(posting.evaluate(context: lookup ?? context))
    }

    mutating func apply(automatedTransaction: AutomatedTransaction, context: @escaping ExpressionContext) throws {
        let transactionLookup = lookup ?? context
        for evaluatedPosting in postings {
            guard try evaluatedPosting.match(expression: automatedTransaction.expression, context: transactionLookup) else { continue }
            for automatedPosting in automatedTransaction.postings {
                let value = try automatedPosting.value.evaluate(context: transactionLookup)
                guard case .amount(var amount) = value else { throw ExpressionError.posting }
                if !amount.hasCommodity {
                    amount.commodity = evaluatedPosting.amount.commodity
                    amount.number *= evaluatedPosting.amount.number
                }
                postings.append(EvaluatedPosting(account: automatedPosting.account, amount: amount, cost: nil, virtual: automatedPosting.virtual))
            }
        }
    }

    func matches(_ search: [Filter]) -> Bool {
        return search.all(matches)
    }

    func matches(_ search: Filter) -> Bool {
        switch search {
        case .account:
            return postings.first { $0.matches(search) } != nil
        case .string(let string):
            return title.lowercased().contains(string.lowercased()) || postings.first { $0.matches(search) } != nil
        case .period(let from, let to):
            return date >= from && date <= to
        }
    }
}

// MARK: - Equatable

extension EvaluatedTransaction: Equatable  {

    static func ==(lhs: EvaluatedTransaction, rhs: EvaluatedTransaction) -> Bool {
        return lhs.title == rhs.title && lhs.postings == rhs.postings && lhs.date == rhs.date
    }
}

// MARK: - CustomStringConvertible

extension EvaluatedTransaction: CustomStringConvertible {

    var description: String {
        let displayPostings = postings.map { $0.description }.joined(separator: "\n")
        return "\(date)\n\(displayPostings)"
    }
}

