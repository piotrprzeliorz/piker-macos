//
//  DocumentWindowController.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class DocumentWindowController: NSWindowController {

    // MARK: - Variables

    var didSearch: ((String) -> ()) = { _ in }
    var balanceViewController: BalanceViewController? {
        return contentViewController?.children.first(where: { $0 is BalanceViewController }) as? BalanceViewController
    }
    var registerViewController: RegisterViewController? {
        return contentViewController?.children.first(where: { $0 is RegisterViewController }) as? RegisterViewController
    }

    // MARK: - IBActions

    @IBAction private func searchTextFieldValueChanged(_ sender: NSSearchField) {
        didSearch(sender.stringValue)
    }
}

