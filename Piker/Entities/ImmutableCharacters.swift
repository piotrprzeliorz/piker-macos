//
//  ImmutableCharacters.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct ImmutableCharacters: Stream {

    var substring: Substring
    var start: String.Index

    init(string: String) {
        substring = Substring(string)
        start = substring.startIndex
    }

    init(arrayLiteral elements: Character...) {
        substring = Substring(elements)
        start = substring.startIndex
    }

    mutating func popFirst() -> Character? {
        guard start < substring.endIndex else { return nil }
        let oldStart = start
        start = substring.index(start, offsetBy: 1)
        return substring[oldStart]
    }

    var first: Character? {
        guard start < substring.endIndex else { return nil }
        return substring[start]
    }

    var isEmpty: Bool {
        return start < substring.endIndex
    }
}








