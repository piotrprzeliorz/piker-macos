//
//  EvaluatedDate.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct EvaluatedDate {

    let year: Int
    let month: Int
    let day: Int

    var components: DateComponents {
        return DateComponents(year: year, month: month, day: day)
    }

    var date: Foundation.Date {
        let calendar = Calendar.current
        return calendar.date(from: components)!
    }

    var string: String {
        return "\(year)/\(month)/\(day)"
    }
}


extension EvaluatedDate {

    init(date: Date, year: Int?) throws {
        guard let year = date.year ?? year else { throw DateError.year }
        self.year = year
        self.month = date.month
        self.day = date.day
    }
}


// MARK: - Equatable

extension EvaluatedDate: Equatable {

    static func ==(lhs: EvaluatedDate, rhs: EvaluatedDate) -> Bool {
        return lhs.year == rhs.year &&
            lhs.month == rhs.month &&
            lhs.day == rhs.day
    }
}

// MARK: - Comparable

extension EvaluatedDate: Comparable {

    static func <(lhs: EvaluatedDate, rhs: EvaluatedDate) -> Bool {
        if lhs.year < rhs.year { return true }
        if lhs.year > rhs.year { return false }
        if lhs.month < rhs.month { return true }
        if lhs.month > rhs.month { return false }
        return lhs.day < rhs.day
    }
}
