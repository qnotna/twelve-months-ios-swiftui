//
//  Availability.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Availability: Decodable {
    var regions: [Region]
    var stored: [Month]?
    var fresh: [Month]?
}

