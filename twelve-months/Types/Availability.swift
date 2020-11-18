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
    
    #warning("Associated value should never be '0'")
    case highest = 4,
         high    = 3,
         low     = 2,
         lowest  = 1,
         none    = 0
    
    var description: String {
        switch self {
        case .lowest:  return "Small"
        case .low:     return "Medium"
        case .high:    return "Large"
        case .highest: return "Heavy"
        default:       return "This should never happen"
        }
    }
    
}
