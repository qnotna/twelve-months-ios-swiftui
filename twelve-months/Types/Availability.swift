//
//  Availability.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

enum Availability: Int, Decodable, CustomStringConvertible {
    case none, lowest, low, high, highest

    var description: String {
        switch self {
        case .lowest: return "Small"
        case .low: return "Medium"
        case .high: return "Large"
        case .highest: return "Heavy"
        default: return "Not available"
        }
    }
}
