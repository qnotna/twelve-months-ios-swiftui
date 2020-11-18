//
//  Food.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Food: Decodable, Equatable {
    
    var name: String
    var localizedName: String
    var type: FoodType
    var importByMonth: [Availability]
    var cultivationByMonth: [Availability]
    
    #warning("Calculate this lazily instead")
    var percentagePerMonth: [Int]? {
        var percentages = [Int]()
        for i in 0...11 {
            let cultivated = cultivationByMonth[i].rawValue
            let imported = importByMonth[i].rawValue
            if cultivated + imported != 0 {
                let percentage = (Double(cultivated) / ( Double(cultivated) + Double(imported) )) * 100
                percentages.append(Int(percentage))
            } else {
                percentages.append(-1)
            }
        }
        return percentages
    }
    
}
