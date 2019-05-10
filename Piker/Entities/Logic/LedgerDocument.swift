//
//  Document.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class LedgerDocument: NSDocument {

    // MARK: - Variables

    private var controller: DocumentController!

    // MARK: - API

    override class func canConcurrentlyReadDocuments(ofType typeName: String) -> Bool {
        return true
    }

    override func read(from data: Data, ofType typeName: String) throws {
        guard let contents = String(data: data, encoding: .utf8) else { throw GenericError.data }
        var ledger = Ledger()
        let statements = parse(string: contents)
        for statement in statements {
            try! ledger.apply(statement)
        }
        controller = DocumentController(ledger: ledger)
    }

    override func makeWindowControllers() {
        let windowController: DocumentWindowController = NSStoryboard(storyboard: .main).instantiateController()
        addWindowController(windowController)
        windowController.document = self
        windowController.showWindow(nil)
        controller.windowController = windowController
    }
}
