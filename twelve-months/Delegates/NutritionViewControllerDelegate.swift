//
//  NutritionViewControllerDelegate.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol NutritionViewControllerDelegate {
        
    func currentNutritionValueChanged() -> Void
    
    func segmentedControl(didChange index: Int) -> Void
    
    func getSelectedSegmentIndex(_ index: Int) -> Void
    
}
