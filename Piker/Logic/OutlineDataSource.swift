//
//  OutlineDataSource.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class OutlineDataSource<A: Tree, Cell: BalanceCell>: NSObject, NSOutlineViewDelegate, NSOutlineViewDataSource {

    // MARK: - Variables

    private var tree: [TreeBox<A>] = []
    var configure: (A, BalanceCell) -> () = { _,_  in }
    var didSelect: (A?) -> () = { _ in }

    var rootItems: [A] {
        get {
            return tree.map { $0.unbox }
        }
        set {
            tree = newValue.map(TreeBox.init)
        }
    }

    // MARK: - Life cycle

    init(configure: @escaping (A, BalanceCell) -> ()) {
        self.configure = configure
    }

    // MARK: - Private

    private func children(item: Any?) -> [TreeBox<A>] {
        guard let item = item else { return tree }
        return (item as! TreeBox<A>).children
    }

    // MARK: - NSOutlineViewDelegate, NSOutlineViewDataSource

    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return children(item: item).count
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return children(item: item).count > 0
    }

    func outlineViewSelectionDidChange(_ notification: Notification) {
        let outlineView = notification.object as! NSOutlineView
        didSelect((outlineView.item(atRow: outlineView.selectedRow) as? TreeBox<A>)?.unbox)
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return children(item: item)[index]
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let boxed = item as? TreeBox<A> else { return nil }
        let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: BalanceCell.identifier), owner: self)! as! BalanceCell
        configure(boxed.unbox, cell)
        return cell
    }

}

