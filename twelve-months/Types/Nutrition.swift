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

struct VegetableData {
    // per day
    let amount: Double // given in c (cups)
    let portions: Double
    
    // amount (in c) per week
    let darkGreen: Double
    let orange: Double
    let legumes: Double
    let starchy: Double
    let other: Double
}

struct FruitData {
    // per day
    let amount: Double // given in c (cups)
    let portions: Double
}

struct EatingPatterns {
    // calculate VegetableData based on given calories
    static func getVegetableAmount(calories kcal: Double) -> VegetableData {
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
        
        return VegetableData(amount: data[0], portions: data[1], darkGreen: data[2], orange: data[3], legumes: data[4], starchy: data[5], other: data[6])
        
    }
    
    static func getFruitAmount(calories kcal: Double) -> FruitData {
        if (kcal <= 1200) {
            return FruitData(amount: 1, portions: 2)
        }
        else if (kcal <= 1800) {
            return FruitData(amount: 1.5, portions: 3)
        }
        else if (kcal <= 2600) {
            return FruitData(amount: 2, portions: 4)
        }
        else {
            return FruitData(amount: 2.5, portions: 5)
        }
        
    }
}
