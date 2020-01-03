//
//  Region.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 16.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Region: Decodable {
    
    var name: RegionType
    var countries: [String]
    
}
