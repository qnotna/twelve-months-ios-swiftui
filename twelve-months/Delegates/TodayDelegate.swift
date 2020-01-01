//
//  TodayDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

protocol TodayDelegate {
    
    func today(didUpdateTitle title: String) -> Void

}
