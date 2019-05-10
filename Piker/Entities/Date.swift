//
//  Date.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Date {
    let year: Int?
    let month: Int
    let day: Int
}

extension Date: Equatable {

    static func ==(lhs: Date, rhs: Date) -> Bool {
        return lhs.year == rhs.year &&
            lhs.month == rhs.month &&
            lhs.day == rhs.day
    }
}



