//
//  Double.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

extension Double {

    private static let formatter = NumberFormatter()

    func displayFormat(commodity: String?) -> String {
        Double.formatter.currencySymbol = commodity
        Double.formatter.numberStyle = .currencyAccounting
        return Double.formatter.string(from: self as NSNumber) ?? ""
    }

    var color: NSColor {
        return 0 > self ? .red : .gray
    }
}
