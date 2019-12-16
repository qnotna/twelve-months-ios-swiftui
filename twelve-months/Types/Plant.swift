//
//  Plant.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Plant: Decodable {
    var type: PlantType
    var name: String
    var availability: [Availability]
    var footprint: Int?
}
