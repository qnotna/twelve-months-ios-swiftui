//
//  DetailSection.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

enum DetailSection: Int, CaseIterable {
    case monthly, yearly
}

extension DetailSection: CustomStringConvertible {
    var description: String {
        switch self {
        case .monthly: return "Monthly Availability"
        case .yearly: return "Yearly Availability"
        }
    }
}
