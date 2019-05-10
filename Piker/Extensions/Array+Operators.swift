//
//  Array+Operators.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func remove(where test: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        var newSelf: [Element] = []
        for x in self {
            if test(x) {
                result.append(x)
            } else {
                newSelf.append(x)
            }
        }
        self = newSelf
        return result
    }

    func all(_ f: (Element) -> Bool) -> Bool {
        for x in self {
            if !f(x) {
                return false
            }
        }
        return true
    }

    func some(_ f: (Element) -> Bool) -> Bool {
        for x in self {
            if f(x) {
                return true
            }
        }
        return false
    }

    mutating func index(where f: (Element) -> Bool, orAppend element: Element) -> Index {
        if let index = index(where: f) {
            return index
        }
        append(element)
        return endIndex - 1
    }

    var decompose: (Element, [Element])? {
        guard !isEmpty else { return nil }
        var copy = self
        let firstElement = copy.remove(at: 0)
        return (firstElement, copy)
    }
}
