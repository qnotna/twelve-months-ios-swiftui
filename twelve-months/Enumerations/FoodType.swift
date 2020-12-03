//
//  FoodType.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

enum FoodType: Decodable, CaseIterable {
    
    case vegetable, fruit
    
    /// Toggles `FoodType` between `.vegetable` and `.fruit`
    mutating func toggle() {
        guard self == .vegetable else { self = .vegetable; return }
        guard self == .fruit else { self = .fruit; return }
    }
    
}

extension FoodType: RawRepresentable {
    /// Use explicit `rawValue` for decoding from JSON
    var rawValue: String { "\(self)" }
    
    init?(rawValue: String) {
        switch rawValue {
        case "Vegetable": self = .vegetable
        case "Fruit": self = .fruit
        default: fatalError("Unexpectedly found illegal fruitType \(rawValue)")
        }
    }
}

extension FoodType: CustomStringConvertible {
    var description: String {
        switch self {
        case .vegetable: return "Vegetable"
        case .fruit:     return "Fruit"
        }
    }
}
