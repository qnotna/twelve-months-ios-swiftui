//
//  MonthTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class MonthTableViewController: UITableViewController, TodayDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func today(didUpdateTitle title: String) {
        self.title = title
    }
    
//    let month = Month.current
//    let region = RegionType.current
//    let foods = Bundle.main.decode([Food].self, from: "foods.json")
//    var availableFresh = [String]()
//    var availableStored = [String]()
//
//        monthLabel.text = "\(month.rawValue)"
//        regionLabel.text = "\(region.rawValue)"
//
//        foods.forEach() { food in
//            for available in food.availability {
//                if let fresh = available.fresh {
//                    if fresh.contains(month) {
//                        availableFresh.append(food.name)
//                    }
//                }
//                if let stored = available.stored {
//                    if stored.contains(month) {
//                        availableStored.append(food.name)
//                    }
//                }
//            }
//        }
//
//        freshLabel.text = availableFresh.description
//        storedLabel.text = availableStored.description
//    }

}
