//
//  FoodType.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

enum FoodType: String, Decodable {
    
    case fruit = "Fruit",
         vegetable = "Vegetable"
    
    case other =  "Only fruits and vegetables are supported at this time."
    
}
