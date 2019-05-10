//
//  DocumentController.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

final class DocumentController {

    // MARK: - Variables

    private(set) var ledger: Ledger {
        get {
            return documentState.ledger
        }
        set {
            documentState.ledger = newValue
        }
    }

    var documentState = DocumentState() { didSet { update() } }
    var windowController: DocumentWindowController? { didSet { reloadBalanceViewController() } }

    // MARK: - Life cycle

    init(ledger: Ledger) {
        self.ledger = ledger
    }

    // MARK: - Pirvate

    private func reloadBalanceViewController() {
        windowController?.balanceViewController?.didSelect { account in
            self.documentState.filters = account.map { [.account($0)] } ?? []
        }
        windowController?.didSearch = { search in
            self.documentState.filters = Filter.parse(search)
        }
        update()
    }

    private func update() {
        DispatchQueue.main.async {
            self.windowController?.balanceViewController?.ledger = self.ledger
            self.windowController?.registerViewController?.transactions = self.documentState.filteredTransactions
            self.windowController?.registerViewController?.filters = self.documentState.filters
        }
    }
}
