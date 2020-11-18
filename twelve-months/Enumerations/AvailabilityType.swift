//
//  AvailabilityType.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

enum AvailabilityType: String {
    
    case fresh = "Fresh",
         imported = "Imported"
    
    #warning("String should never be empty")
    case none = ""
    
}
