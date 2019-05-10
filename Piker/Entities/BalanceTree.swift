//
//  BalanceTree.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

protocol Tree {
    var children: [Self] { get }
}

struct BalanceTreeNode: Tree {

    var amount: MultiCommodityAmount
    var children: [BalanceTreeNode] = []
    var path: [String]

    var title: String {
        return path.last ?? ""
    }

    var accountName: String {
        return path.joined(separator: ":")
    }

    init(accountName: String?, amount: MultiCommodityAmount) {
        path = accountName?.components(separatedBy: ":") ?? []
        self.amount = amount
    }

    init(path: [String], amount: MultiCommodityAmount = MultiCommodityAmount()) {
        self.path = path
        self.amount = amount
    }

    private mutating func insert(node: BalanceTreeNode, path: [String]) {
        guard let (namePrefix, remainingPath) = path.decompose else { return }
        self.amount += node.amount
        let parentNode = remainingPath.isEmpty ? node : BalanceTreeNode(path: self.path + [namePrefix])
        let index = children.index(where: { $0.title == namePrefix }, orAppend: parentNode)
        children[index].insert(node: node, path: remainingPath)
    }

    mutating func insert(node: BalanceTreeNode) {
        insert(node: node, path: node.path)
    }
}
