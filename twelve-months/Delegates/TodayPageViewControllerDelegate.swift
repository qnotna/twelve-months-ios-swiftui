//
//  PageViewControllerDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol TodayPageViewControllerDelegate {
    
    func pageView(didUpdateChildrenViewControllerDataFor month: Month, with food: [Food]) -> Void
    
}
