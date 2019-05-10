//
//  NSView+Constraints.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

extension NSView {

    func edges(toMarginOf otherView: NSView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: otherView.topAnchor),
            bottomAnchor.constraint(equalTo: otherView.bottomAnchor),
            leftAnchor.constraint(equalTo: otherView.leftAnchor),
            rightAnchor.constraint(equalTo: otherView.rightAnchor)
        ])
    }
}
