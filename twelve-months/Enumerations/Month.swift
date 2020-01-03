//
//  Month.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

enum Month: String, Decodable, CaseIterable {
    
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
    
    case other = "Month unknown"
    
    /// This can be called at all times to receive the current month as Month case
    /// Will default to unknown month
    static var current: Month {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: Date())
        if let month = Month(rawValue: month) {
            return month
        }
        return Month.other
    }
    
}
