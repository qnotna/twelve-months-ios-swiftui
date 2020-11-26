//
//  FoodType.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

enum FoodType: String, Decodable, CustomStringConvertible {
    
    case fruit = "Fruit", vegetable = "Vegetable"
    
    /// Toggles `FoodType` between `.vegetable` and `.fruit`
    mutating func toggle() {
        guard self == .vegetable else { self = .vegetable; return }
        guard self == .fruit else { self = .fruit; return }
    }
    
    var description: String {
        switch self {
        case .vegetable: return "Vegetable"
        case .fruit:     return "Fruit"
        }
    }
    
}
