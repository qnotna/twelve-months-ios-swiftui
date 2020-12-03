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

    /// Ratio between `importByMonth` and `cultivationByMonth`
    var ratio: [Int]? {
        var percentages = [Int]()
        for month in 0 ... Month.allCases.count - 1 {
            let cultivated = cultivationByMonth[month].rawValue
            let imported = importByMonth[month].rawValue
            if cultivated + imported != 0 {
                let percentage = (Double(cultivated) / (Double(cultivated) + Double(imported))) * 100
                percentages.append(Int(percentage))
            } else {
                percentages.append(-1)
            }
        }
        return percentages
    }

    static var vegetablesUrl = "vegetables.json"
    static var fruitsUrl = "fruits.json"
}
