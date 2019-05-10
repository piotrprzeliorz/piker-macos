//
//  Statement.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum Statement {
    case definition(name: String, expression: Expression)
    case tag(String)
    case account(String)
    case automated(AutomatedTransaction)
    case transaction(Transaction)
    case comment(String)
    case commodity(String)
    case year(Int)
}

// MARK: - Equatable

extension Statement: Equatable {

    static func ==(lhs: Statement, rhs: Statement) -> Bool {
        switch (lhs, rhs) {
        case let (.definition(ln, le), .definition(rn, re)):
            return ln == rn && le == re
        case let (.tag(l), .tag(r)):
            return l == r
        case let (.account(l), .account(r)):
            return l == r
        case let (.automated(l), .automated(r)):
            return l == r
        case let (.transaction(l), .transaction(r)):
            return l == r
        case let (.comment(l), .comment(r)):
            return l == r
        case let (.commodity(l), .commodity(r)):
            return l == r
        case let (.year(l), .year(r)):
            return l == r
        default:
            return false
        }
    }

}



