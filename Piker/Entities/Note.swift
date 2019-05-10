//
//  Note.swift
//  Piker
//
//  Created by Piotr Przeliorz on 25/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum PostingOrNote {
    case posting(Posting)
    case note(Note)
}

struct Note {

    let comment: String

    init(_ comment: String) {
        self.comment = comment
    }
}

// MARK: - Equatable

extension Note: Equatable {

    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.comment == rhs.comment
    }
}


