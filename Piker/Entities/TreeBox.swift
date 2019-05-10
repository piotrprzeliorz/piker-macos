//
//  TreeBox.swift
//  Piker
//
//  Created by Piotr Przeliorz on 10/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

final class TreeBox<T: Tree> {

    let unbox: T
    var children: [TreeBox<T>]

    init(_ item: T) {
        self.unbox = item
        self.children = item.children.map { TreeBox($0) }
    }
}
