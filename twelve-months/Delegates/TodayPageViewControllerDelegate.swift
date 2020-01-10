//
//  PageViewControllerDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol TodayPageViewControllerDelegate {
    
    func pageView(didUpdatePageFor month: Month, pageIndex: Int, foodType: FoodType) -> Void

    func pageView(didUpdateFruitsData fruits: (cultivated: [Food], imported: [Food])) -> Void

    func pageView(didUpdateVegetablesData vegetables: (cultivated: [Food], imported: [Food])) -> Void

    func pageView(segmentedControlDidChange index: Int) -> Void
    
}
