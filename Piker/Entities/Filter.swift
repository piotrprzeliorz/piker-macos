//
//  Filter.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum FilterToken: Equatable {
    case year(Int)
    case month(Int)
    case other(String)
}

enum Filter {
    case account(String)
    case string(String)
    case period(from: EvaluatedDate, to: EvaluatedDate)

    static func tokenize(_ string: String) -> [FilterToken] {
        let parser = token.separatedBy(spaceWithoutNewline.many1) <* FastParser.eof
        return (try? parser.run(sourceName: "", input: ImmutableCharacters(string: string.lowercased()))) ?? [.other(string)]
    }

    static func parse(_ string: String) -> [Filter] {
        let tokens = tokenize(string)
        var year: Int?
        var month: Int?
        var other: [String] = []
        for token in tokens {
            switch token {
            case .year(let value): year = value
            case .month(let value): month = value
            case .other(let value): other.append(value)
            }
        }
        var period: (EvaluatedDate, EvaluatedDate)?
        switch (year, month) {
        case let (year?, month?):
            let lastDayInMonth = 31
            period = (EvaluatedDate(year: year, month: month, day: 1), EvaluatedDate(year: year, month: month, day: lastDayInMonth))
        case let (year?, _):
            period = (EvaluatedDate(year: year, month: 1, day: 1), EvaluatedDate(year: year, month: 12, day: 31)) // TODO
        case let (_, month?):
            let lastDayInMonth = 31
            let year = Calendar.current.component(.year, from: Foundation.Date())
            period = (EvaluatedDate(year: year, month: month, day: 1), EvaluatedDate(year: year, month: month, day: lastDayInMonth))
        default: ()
        }
        var result = other.map { Filter.string ($0) }
        if let period = period {
            result.append(.period(from: period.0, to: period.1))
        }
        return result
    }
}


