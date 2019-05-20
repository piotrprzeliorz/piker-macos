//
//  RegisterDataSource.swift
//  Piker
//
//  Created by Piotr Przeliorz on 10/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

enum RegisterRow {
    case title(EvaluatedTransaction)
    case posting(EvaluatedPosting)
}

final class RegisterDataSource: NSObject, NSTableViewDelegate, NSTableViewDataSource {

    // MARK: - Variables

    private var filters: [Filter] = []
    private var rows: [RegisterRow] = []

    // MARK: - API

    func setupRows(with transactions: [EvaluatedTransaction]) {
        rows = transactions.flatMap { transaction in
            [.title(transaction)] + transaction.postings.map { .posting($0) }
        }
    }

    func setup(filters: [Filter]) {
        self.filters = filters
    }

    // MARK: - NSTableViewDelegate, NSTableViewDataSource

    func numberOfRows(in tableView: NSTableView) -> Int {
        return rows.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        switch rows[row] {
        case .title(let transaction):
            return transactionCell(tableView, transaction)
        case .posting(let posting):
            return postingCell(tableView, posting)
        }
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        switch rows[row] {
        case .posting:
            return PostingCell.height
        case .title:
            return TransactionCell.height
        }
    }

    func transactionCell(_ tableView: NSTableView, _ transaction: EvaluatedTransaction) -> NSView {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: TransactionCell.identifier), owner: self)! as! TransactionCell
        cell.render(date: transaction.date.date, title: transaction.title)
        return cell
    }

    func postingCell(_ tableView: NSTableView, _ posting: EvaluatedPosting) -> NSView {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: PostingCell.identifier), owner: self)! as! PostingCell
        cell.render(posting: posting, highlighted: filters.some(posting.matches))
        return cell
    }
}

