//
//  Month.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

enum Month: String, Decodable {
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

    /// Determines the current month as case of `self`
    static var current: Month {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let formattedDate = dateFormatter.string(from: Date())
        guard let month = Month(rawValue: formattedDate) else {
            fatalError("Could not determine current month")
        }
        return month
    }
}

extension Month: CaseIterable {
    /// Create index for `month` in `allCases`
    static func index(of month: Month) -> Int {
        /// Protocol conformance guarantees this never fails
        //swiftlint:disable:next force_unwrapping
        return allCases.firstIndex(of: month)!
    }
}
