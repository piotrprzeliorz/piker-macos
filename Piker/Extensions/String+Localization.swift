//
//  String+Localization.swift
//  Piker
//
//  Created by Piotr Przeliorz on 18/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
