//
//  RegisterViewController.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

final class RegisterViewController: NSViewController {

    // MARK: - Constants

    private let dataSource = RegisterDataSource()

    // MARK: - Variables

    private var tableView: NSTableView!

    var transactions: [EvaluatedTransaction] = [] {
        didSet {
            dataSource.setupRows(with: transactions.reversed())
            tableView?.reloadData()
        }
    }
    var filters: [Filter] = [] {
        didSet {
            dataSource.setup(filters: filters)
            tableView?.reloadData()
        }
    }

    // MARK: - VC's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupScrollView()
        setupWidthConstraint()
    }

    // MARK: - Private

    private func setupTableView() {
        let tableView = NSTableView()
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: ""))
        tableView.addTableColumn(column)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.headerView = nil
        let postingNib = NSNib(nibNamed: PostingCell.identifier, bundle: nil)
        tableView.register(postingNib, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: PostingCell.identifier))
        let transactionNib = NSNib(nibNamed: TransactionCell.identifier, bundle: nil)
        tableView.register(transactionNib, forIdentifier: NSUserInterfaceItemIdentifier(rawValue: TransactionCell.identifier))
        self.tableView = tableView
    }

    private func setupScrollView() {
        let scrollView = NSScrollView()
        let clipView = NSClipView()
        clipView.documentView = tableView
        scrollView.contentView = clipView
        view.addSubview(scrollView)
        scrollView.edges(toMarginOf: view)
        scrollView.hasVerticalScroller = true
    }

    private func setupWidthConstraint() {
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 500).isActive = true
    }
}
