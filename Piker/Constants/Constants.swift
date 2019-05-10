//
//  Constants.swift
//  Piker
//
//  Created by Piotr Przeliorz on 18/04/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

typealias ExpressionContext = (String) -> Value?

func ??(lhs: @escaping ExpressionContext, rhs: @escaping ExpressionContext) -> ExpressionContext {
    return { x in
        return lhs(x) ?? rhs(x)
    }
}
