//
//  OverviewSection.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 18.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

enum OverviewSection: Int, CustomStringConvertible, CaseIterable {
    
    case cultivation, importOnly
    
    var description: String {
        switch self {
        case .cultivation: return "Local Cultivation"
        case .importOnly:  return "Import Only"
        }
    }
}
