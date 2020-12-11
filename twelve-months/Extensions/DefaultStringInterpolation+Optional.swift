//
//  DefaultStringInterpolation+Optional.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 11.12.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

extension DefaultStringInterpolation {
    /// Force unwrap optionals in interpolated strings.
    /// Silences warning: `String interpolation produces a debug description for an optional value`
    mutating func appendInterpolation<T>(optional: T?) {
        //swiftlint:disable:next force_unwrapping
        appendInterpolation(optional!)
    }
}
