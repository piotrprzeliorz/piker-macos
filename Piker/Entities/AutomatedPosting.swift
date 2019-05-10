//
//  AutomatedPosting.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct AutomatedPosting {

    var account: String
    var value: Expression
    var virtual: Bool
}

extension AutomatedPosting {
    init(account: (String, Bool), value: Expression) {
        self.account = account.0
        self.value = value
        self.virtual = account.1
    }
}

// MARK: - Equatable

extension AutomatedPosting: Equatable {

    static func ==(lhs: AutomatedPosting, rhs: AutomatedPosting) -> Bool {
        return lhs.account == rhs.account && lhs.value == rhs.value && lhs.virtual == rhs.virtual
    }
}



