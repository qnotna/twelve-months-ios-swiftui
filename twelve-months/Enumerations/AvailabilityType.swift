//
//  AvailabilityType.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 18.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

enum AvailabilityType: Int, CaseIterable {
    case cultivation, importOnly
}

extension AvailabilityType: CustomStringConvertible {
    var description: String {
        switch self {
        case .cultivation: return "Local Cultivation"
        case .importOnly: return "Import Only"
        }
    }
}
