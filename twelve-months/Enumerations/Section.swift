//
//  Section.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 18.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

enum Section: Int, CustomStringConvertible {
    
    case cultivation, importOnly
    
    var description: String {
        self == .cultivation ? "Local Cultivation" : "Import Only"
    }
}
