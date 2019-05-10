//
//  PostingCell.swift
//  Piker
//
//  Created by Piotr Przeliorz on 10/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class PostingCell: NSView {

    static let height: CGFloat = 20

    @IBOutlet private weak var accountTextField: NSTextField!
    @IBOutlet private weak var amountTextField: NSTextField!

    func render(posting: EvaluatedPosting, highlighted: Bool) {
        let font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
        let accountFont = posting.virtual ? font.italic : font
        var attributes: [NSAttributedString.Key: AnyObject] = [.font: accountFont]
        if highlighted {
            attributes[.backgroundColor] = NSColor.yellow.withAlphaComponent(0.3)
        }
        accountTextField.attributedStringValue = NSAttributedString(string: posting.account, attributes: attributes)
        amountTextField.attributedStringValue = NSAttributedString(string: posting.amount.number.value.displayFormat(commodity: posting.amount.commodity.value), attributes: attributes)
        amountTextField.textColor = posting.amount.number.value.color
    }
}

