//
//  MonthTableViewControllerDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 10.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol MonthTableViewControllerDelegate {
    
    func monthTableView(didPresentPreviewFor item: Food, at indexPath: IndexPath, and pageIndex: Int) -> Void
    
}
