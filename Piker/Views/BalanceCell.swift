//
//  BalanceCell.swift
//  Piker
//
//  Created by Piotr Przeliorz on 09/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class BalanceCell: NSTableCellView {
    
    @IBOutlet private  weak var amountTextField: NSTextField!
    @IBOutlet private weak var titleTextField: NSTextField!

    func render(amount: Amount, title: String) {
        titleTextField.stringValue = title
        amountTextField.stringValue = amount.number.value.displayFormat(commodity: amount.commodity.value)
        amountTextField.textColor = amount.number.value.color
    }
}
