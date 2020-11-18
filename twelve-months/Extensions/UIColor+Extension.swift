//
//  UIColor+Extension.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 18.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    #warning("Find matching colors for traffic light")
    #warning("Default case should result in fatal error")
    /// Maps `Availability` cases to `UIColor`
    /// - Parameter availability: import availability
    /// - Returns: color for availability
    static func matching(availability: Availability) -> UIColor {
        switch availability {
        case .lowest:   return .systemOrange
        case .low:      return .systemRed
        case .high:     return .systemPurple
        case .highest:  return .gray
        default:        return .clear
        }
    }
    
}
