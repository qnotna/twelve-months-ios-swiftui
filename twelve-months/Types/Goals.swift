//
//  Goals.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

struct NutritionProgress {
    let name: String
    let isMain: Bool
    let currentValue: Double
    let goalValue: Double
    var progress: Double {
        currentValue / goalValue
    }
}



