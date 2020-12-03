//
//  Goods.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 18.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

/// Data source for any food in a given month
struct Goods {
    var cultivated = [Food]()
    var imported = [Food]()
    var identifier = UUID()
}

#warning("Use this for 'UIDiffableDataSource'")
extension Goods: Hashable {
    /// Only represent hash from `identifier`
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
