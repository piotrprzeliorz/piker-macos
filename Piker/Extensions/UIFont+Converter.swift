//
//  UIFont+Converter.swift
//  Piker
//
//  Created by Piotr Przeliorz on 09/05/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

extension NSFont {
    
    var italic: NSFont {
        return NSFontManager.shared.convert(self, toHaveTrait: .italicFontMask)
    }
}
