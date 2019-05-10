//
//  AutomatedTransaction.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct AutomatedTransaction {

    var expression: Expression
    var postings: [AutomatedPosting]
}

// MARK: - Equatable

extension AutomatedTransaction: Equatable {

    static func ==(lhs: AutomatedTransaction, rhs: AutomatedTransaction) -> Bool {
        return lhs.expression == rhs.expression &&
            lhs.postings == rhs.postings
    }
}


