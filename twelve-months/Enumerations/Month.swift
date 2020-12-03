//
//  Month.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

#warning("Possibly use 'GregorianMonth' instead")
enum Month: String, Decodable, CaseIterable {
    case january = "January",
         february = "February",
         march = "March",
         april = "April",
         may = "May",
         june = "June",
         july = "July",
         august = "August",
         september = "September",
         october = "October",
         november = "November",
         december = "December"

    /// This can be called at all times to receive the current month as Month case
    /// Will default to unknown month
    static var current: Month {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: Date())
        if let month = Month(rawValue: month) {
            return month
        }
        fatalError("Could not determine current month")
    }
}
