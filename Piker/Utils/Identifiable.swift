//
//  Identifiable.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

protocol Identifiable {

    static var identifier: String { get }
}

extension Identifiable {

    static var identifier: String {
        return String(describing: self)
    }
}
