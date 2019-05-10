//
//  Expression.swift
//  Piker
//
//  Created by Piotr Przeliorz on 18/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum Expression {
    indirect case infix(`operator`: String, lhs: Expression, rhs: Expression)
    case amount(Amount)
    case bool(Bool)
    case ident(String)
    case regex(String)
    case string(String)
}

extension Expression {
    
    func evaluate(context: ExpressionContext = { _ in return nil }) throws -> Value {
        switch self {
        case .amount(let amount):
            return .amount(amount)
        case .infix(let op, let lhs, let rhs):
            let left = try lhs.evaluate(context: context)
            let right = try rhs.evaluate(context: context)
            switch op {
            case "*":
                return try .amount(left.op(double: *, right))
            case "/":
                return try .amount(left.op(double: /, right))
            case "+":
                return try .amount(left.op(double: +, right))
            case "-":
                return try .amount(left.op(double: -, right))
            case "=~":
                return try .bool(left.matches(right))
            case "&&":
                return try .bool(left.op(bool: { $0 && $1 }, right))
            case "||":
                return try .bool(left.op(bool: { $0 || $1 }, right))
            case "==":
                return .bool(left == right)
            default:
                fatalError("Unknown operator: \(op)")
            }

        case .ident(let name):
            guard let value = context(name) else { throw ExpressionError.unknownVariable}
            return value
        case .string(let string):
            return .string(string)
        case .regex(let regex):
            return .regex(regex)
        case .bool(let bool):
            return .bool(bool)
        }
    }
}

// MARK: - Equatable

extension Expression: Equatable {

    static func ==(lhs: Expression, rhs: Expression) -> Bool {
        switch (lhs, rhs) {
        case let (.infix(op1, lhs1, rhs1), .infix(op2, lhs2, rhs2)) where op1 == op2 && lhs1 == lhs2 && rhs1 == rhs2:
            return true
        case let(.amount(x), .amount(y)) where x == y:
            return true
        case let(.ident(x), .ident(y)) where x == y:
            return true
        case let(.regex(x), .regex(y)) where x == y:
            return true
        case let(.string(x), .string(y)) where x == y:
            return true
        case let(.bool(x), .bool(y)) where x == y:
            return true
        default: return false
        }
    }
}


