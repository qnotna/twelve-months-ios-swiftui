//
//  Nutrition.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 06.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Calories {
    static func calculateCalories(gender g: Int, height h: Int, weight w: Int, age a: Int, activityMultiplier actv: Double) -> Double {
        let wx = 10 * Double(w)
        let hx = 6.25 * Double(h)
        let ax = 5 * Double(a)
        let genderValue: Double = g == 0 ? 5 : -161
        return (wx + hx - ax + genderValue) * actv
    }
}

struct NutritionData {
    let dailyAmount: Double
    let dailyPortions: Double
    let goals: [Goal]
}

enum GoalTypes {
    case DAILY, WEEKLY
}

struct Goal {
    let name: String
    let type: GoalTypes
    let value: Double
}

struct EatingPatterns {
    // calculate VegetableData based on given calories
    static func getVegetableAmount(calories kcal: Double) -> NutritionData {
        var data = [Double]()
        if (kcal <= 1000) {
            data = [1, 2, 1, 0.5, 0.5, 1.5, 4]
        } else if (kcal <= 1200) {
            data = [1.5, 3, 1.5, 1, 1, 2.5, 4.5]
        }
        else if (kcal <= 1400) {
            data = [1.5, 3, 1.5, 1, 1, 2.5, 4.5]
        }
        else if (kcal <= 1600) {
            data = [2, 4, 2 ,1.5 ,2.5 ,2.5 ,5.5]
        }
        else if (kcal <= 1800) {
            data = [2.5, 5, 3 ,2 ,3 , 3 ,6.5]
        }
        else if (kcal <= 2000) {
            data = [2.5, 5, 3 ,2 ,3 ,  3 , 6.5]
        }
        else if (kcal <= 2200) {
            data = [3, 6, 3 ,2 ,3 ,6 ,7 ]
        }
        else if (kcal <= 2400) {
            data = [3, 6, 3 ,2 ,3 ,6 ,7 ]
        }
        else if (kcal <= 2600) {
            data = [3.5, 7, 3 ,2.5 ,3.5 ,7 ,8.5 ]
        }
        else if (kcal <= 2800) {
            data = [3.5, 7, 3 ,2.5 ,3.5 ,7 ,8.5 ]
        }
        else if (kcal <= 3000) {
            data = [4, 8, 3 ,2.5 ,3.5 ,9 ,10 ]
        }
        else {
            data = [4, 8, 3 ,2.5 ,3.5 ,9 ,10 ]
        }
        
        return NutritionData(dailyAmount: data[0], dailyPortions: data[1], goals: [
            Goal(name: "Vegetables", type: GoalTypes.WEEKLY, value: data[0] * 7),
            Goal(name: "Dark Green veg.", type: GoalTypes.WEEKLY, value: data[2]),
            Goal(name: "Orange veg.", type: GoalTypes.WEEKLY, value: data[3]),
            Goal(name: "Legumes", type: GoalTypes.WEEKLY, value: data[4]),
            Goal(name: "Starchy veg.", type: GoalTypes.WEEKLY, value: data[5]),
            Goal(name: "Other veg.", type: GoalTypes.WEEKLY, value: data[6]),
        ])
        
    }
    
    static func getFruitAmount(calories kcal: Double) -> NutritionData {
        var data = [Double]()
        if (kcal <= 1200) {
            data = [1, 2]
        }
        else if (kcal <= 1800) {
            data = [1.5, 3]
        }
        else if (kcal <= 2600) {
            data = [2, 4]
        }
        else {
            data = [2.5, 5]
        }
        
        return NutritionData(dailyAmount: data[0], dailyPortions: data[1], goals: [
            Goal(name: "Fruits", type: GoalTypes.WEEKLY, value: data[0] * 7)
        ])
        
    }
}
