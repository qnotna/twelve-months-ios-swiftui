//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import Foundation

/// A wrapper for any `FixedWidthInteger` indices that should only stay inside a range of values and roll around when exceeding the range's bounds.
@propertyWrapper struct RollingIndex<Value: FixedWidthInteger> {
    /// The allowed range of values.
    private let range: Range<Value>

    /// Wraps the value and clamps it when bounds are exceeded.
    /// - Rolls around to lower bound if upper bound is reached
    /// - Rolls around to the upper bound if lower bound is reached
    var wrappedValue: Value {
        didSet {
            if wrappedValue > oldValue,
               wrappedValue >= range.upperBound {
                self.wrappedValue = range.lowerBound
            } else if wrappedValue < range.lowerBound {
                self.wrappedValue = range.upperBound - 1
            }
        }
    }

    init(in range: Range<Value>, startingAt index: Value) {
        self.range = range
        self.wrappedValue = index
    }
}
