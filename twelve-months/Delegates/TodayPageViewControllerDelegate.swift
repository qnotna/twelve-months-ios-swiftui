//
//  PageViewControllerDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol TodayPageViewControllerDelegate {
    
    /// Call when the current page changed and a new page is presented
    /// - Parameters:
    ///   - month: new presented month
    ///   - pageIndex: new page index
    func pageView(didCreatePageFor month: Month, at pageIndex: Int) -> Void
    
    /// Call when goods for the current page are ready
    /// - Parameters:
    ///   - vegetables: current vegetables
    ///   - fruits: current fruits
    func pageView(didUpdate vegetables: Goods, and fruits: Goods) -> Void
    
}
