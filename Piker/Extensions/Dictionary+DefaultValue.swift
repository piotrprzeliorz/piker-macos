//
//  Dictionary+DefaultValue.swift
//  Piker
//
//  Created by Piotr Przeliorz on 19/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

extension Dictionary {

    subscript(key: Key, or value: Value) -> Value {
        get {
            return self[key] ?? value
        }
        set {
            self[key] = newValue
        }
    }
}
