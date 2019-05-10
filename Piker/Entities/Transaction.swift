//
//  Transaction.swift
//  Piker
//
//  Created by Piotr Przeliorz on 19/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum TransactionState: Character {
    case cleared = "*"
    case pending = "!"
}

// MARK: - Equatable

extension TransactionState: Equatable { }

struct Transaction {

    var postings: [Posting]
    var date: Date
    var state: TransactionState?
    var title: String
    var notes: [Note]


    func evaluate(automatedTransactions: [AutomatedTransaction], year: Int?, context: @escaping ExpressionContext) throws -> EvaluatedTransaction {
        var postingsWithValue = postings
        let postingsWithoutValue = postingsWithValue.remove { $0.value == nil }
        var evaluatedTransaction = try EvaluatedTransaction(title: title, postings: [], date: EvaluatedDate(date: date, year: year))

        for posting in postingsWithValue {
            try evaluatedTransaction.append(posting: posting, context: context)
        }

        guard postingsWithoutValue.count <= 1 else { throw ExpressionError.transactionWithoutAmount }

        if let postingWithoutValue = postingsWithoutValue.first {
            for (commodity, value) in evaluatedTransaction.balance {
                let amount = Amount(-value, commodity: commodity)
                evaluatedTransaction.postings.append(EvaluatedPosting(account: postingWithoutValue.account, amount: amount, cost: nil, virtual: postingWithoutValue.virtual))
            }
        }

        for automatedTransaction in automatedTransactions {
            try evaluatedTransaction.apply(automatedTransaction: automatedTransaction, context: context)
        }

        try evaluatedTransaction.verify()
        return evaluatedTransaction
    }

    
}

extension Transaction {

    init(dateStateAndTitle: (Date, TransactionState?, String), comment: Note?, items: [PostingOrNote]) {
        var transactionNotes: [Note] = []
        var postings: [Posting] = []
        if let note = comment {
            transactionNotes.append(note)
        }
        for postingOrNote in items {
            switch postingOrNote {
            case .posting(let posting):
                postings.append(posting)
            case .note(let note) where postings.isEmpty:
                transactionNotes.append(note)
            case .note(let note):
                postings[postings.count - 1].notes.append(note)
            }
        }
        self = Transaction(postings: postings, date: dateStateAndTitle.0, state: dateStateAndTitle.1, title: dateStateAndTitle.2, notes: transactionNotes)
    }
}


// MARK: - Equatable

extension Transaction: Equatable {

    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.date == rhs.date &&
            lhs.state == rhs.state &&
            lhs.title == rhs.title &&
            lhs.notes == rhs.notes &&
            lhs.postings == rhs.postings
    }
}
