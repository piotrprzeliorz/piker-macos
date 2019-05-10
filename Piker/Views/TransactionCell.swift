//
//  TransactionCell.swift
//  Piker
//
//  Created by Piotr Przeliorz on 10/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class TransactionCell: NSView {

    static let height: CGFloat = 35

    @IBOutlet private weak var dateTextField: NSTextField!
    @IBOutlet private weak var titleTextField: NSTextField!

    func render(date: Foundation.Date, title: String) {
        titleTextField.stringValue = title
        guard let displayableDate = date.short else { return }
        dateTextField.stringValue = displayableDate
    }
}
