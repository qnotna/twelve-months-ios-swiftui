//
//  Availability.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

enum Availability: Int, Decodable {
    
    case highest = 4
    case high = 3
    case low = 2
    case lowest = 1
    case none = 0
    
}
