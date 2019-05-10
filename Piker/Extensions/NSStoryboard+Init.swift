//
//  NSStoryboard+Static.swift
//  Piker
//
//  Created by Piotr Przeliorz on 26/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Cocoa

enum Storyboard: String {
    case main
}

extension NSStoryboard {

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue.capitalized, bundle: bundle)
    }

    func instantiateController<T: Identifiable>() -> T  {
        guard let viewController = self.instantiateController(withIdentifier: T.identifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.identifier) ")
        }
        return viewController
    }
}
