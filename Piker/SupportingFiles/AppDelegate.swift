//
//  AppDelegate.swift
//  Piker
//
//  Created by Piotr Przeliorz on 18/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Variables

    private var ledger: LedgerDocument!

    // MARK: - App's life cycle

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        createDocument()
        ledger.makeWindowControllers()
    }

    // MARK: - Private

    private func createDocument() {
        let fileLocation = Bundle.main.path(forResource: "sample_document", ofType: "txt")!
        ledger = try! LedgerDocument(type: "")
        try! ledger.read(from: Data(contentsOf: URL(fileURLWithPath: fileLocation)), ofType: "")
    }
}

