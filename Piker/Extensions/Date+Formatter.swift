//
//  Date+Formatter.swift
//  Piker
//
//  Created by Piotr Przeliorz on 10/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

extension Foundation.Date {

    private static let formatter = DateFormatter()

    var short: String? {
        Foundation.Date.formatter.dateStyle = .short
        Foundation.Date.formatter.timeStyle = .none
        return Foundation.Date.formatter.string(from: self)
    }
}
