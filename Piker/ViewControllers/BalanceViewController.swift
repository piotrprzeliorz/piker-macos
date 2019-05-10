//
//  BalanceViewController.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class BalanceViewController: NSViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var outlineView: NSOutlineView!

    // MARK: - Variables

    private lazy var dataSource: OutlineDataSource<BalanceTreeNode, BalanceCell> = OutlineDataSource(configure: configureCell)
    var ledger: Ledger? {
        didSet {
            guard ledger != oldValue else { return }
            reloadOutlineView()
        }
    }

    // MARK: - VC's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlineView()
    }
    
    // MARK: - API

    func didSelect(_ didSelect: @escaping (_ account: String?) -> ()) {
        dataSource.didSelect = { balanceTreeItem in
            didSelect(balanceTreeItem?.accountName)
        }
    }

    // MARK: - Private

    private func setupOutlineView() {
        dataSource.configure = configureCell
        outlineView.dataSource = dataSource
        outlineView.delegate = dataSource
    }

    private func configureCell(item: BalanceTreeNode, cell: BalanceCell) {
        guard let (key, value) = item.amount.value.first else { return }
        cell.render(amount: Amount(value, commodity: key), title: item.title)
    }

    private func reloadOutlineView() {
        dataSource.rootItems = ledger?.balanceTree ?? []
        outlineView?.reloadData()
        outlineView?.expandItem(nil, expandChildren: true)
    }
}

