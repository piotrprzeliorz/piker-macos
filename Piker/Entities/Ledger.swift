//
//  Ledger.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Ledger: Equatable {
    
    typealias Balance = [String: MultiCommodityAmount]
    var year: Int? = nil
    var definitions: [String: Value] = [:]
    var accounts: Set<String> = []
    var commodities: Set<String> = []
    var tags: Set<String> = []
    var balance: Balance = [:]
    var automatedTransactions: [AutomatedTransaction] = []
    var evaluatedTransactions: [EvaluatedTransaction] = []

    func valid(account: String) -> Bool {
        return accounts.contains(account)
    }

    func valid(commodity: String) -> Bool {
        return commodities.contains(commodity)
    }

    func valid(tag: String) -> Bool {
        return tags.contains(tag)
    }

    func balance(account: String) -> MultiCommodityAmount {
        return self.balance[account] ?? MultiCommodityAmount()
    }

    func lookup(variable name: String) -> Value? {
        return definitions[name]
    }

    mutating func apply(_ statement: Statement) throws {
        do {
            switch statement {
            case .year(let year):
                self.year = year
            case .definition(let name, let expression):
                definitions[name] = try expression.evaluate(context: lookup)
            case .account(let name):
                accounts.insert(name)
            case .commodity(let name):
                commodities.insert(name)
            case .tag(let name):
                tags.insert(name)
            case .comment:
                break
            case .transaction(let transaction):
                let evaluatedTransaction = try transaction.evaluate(automatedTransactions: automatedTransactions, year: year, context: lookup)
                apply(transaction: evaluatedTransaction)
            case .automated(let autoTransaction):
                automatedTransactions.append(autoTransaction)
            }
        } catch {
            throw GenericError.unknown
        }
    }

    mutating func apply(transaction: EvaluatedTransaction) {
        for posting in transaction.postings {
            balance[posting.account, or: MultiCommodityAmount()][posting.amount.commodity] += posting.amount.number
        }
        evaluatedTransactions.append(transaction)
    }

    var balanceTree: [BalanceTreeNode] {
        let sortedAccounts = Array(balance).sorted { p1, p2 in
            return p1.key < p2.key
        }
        var rootItem = BalanceTreeNode(accountName: nil, amount: MultiCommodityAmount())
        for account in sortedAccounts {
            let node = BalanceTreeNode(accountName: account.key, amount: account.value)
            rootItem.insert(node: node)
        }
        return rootItem.children
    }
}


