//
//  PageViewControllerDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol TodayPageViewControllerDelegate {
    
    /// Delegate method that should be called when the month and food data have been updated
    /// This method provides month and food from the TodayPageViewController to it's delegate
    /// - Parameters:
    ///   - month: The MonthViewController's month
    ///   - food: All decoded food data
    func pageView(didUpdateChildrenViewControllerDataFor month: Month, with food: [Food]) -> Void
    
}
