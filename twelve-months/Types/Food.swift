//
//  Food.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Food: Decodable {
    
    var name: String
    var localizedName: String
    var type: FoodType
    var importByMonth: [Availability]
    var cultivationByMonth: [Availability]

}

struct Plant: Decodable {
    let name: String
    let type: String 
    let importByMonth: [Int]
    let cultivationByMonth: [Int]
}
