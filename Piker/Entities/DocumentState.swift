//
//  DocumentState.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct DocumentState {

    var ledger: Ledger = Ledger()
    var filters: [Filter] = []

    var filteredTransactions: [EvaluatedTransaction] {
        guard filters.isEmpty == false else { return ledger.evaluatedTransactions }
        return ledger.evaluatedTransactions.filter { $0.matches(filters) }
    }
}
