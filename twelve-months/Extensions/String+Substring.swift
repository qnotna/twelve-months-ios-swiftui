//
//  String+Substring.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 26.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

extension String {
    
    private func index(from: Int) -> Index {
        index(startIndex, offsetBy: from)
    }
    
    func substring(in range: Range<Int>) -> String {
        let start = index(from: range.lowerBound)
        let end = index(from: range.upperBound)
        return String(self[start..<end])
    }
    
}
