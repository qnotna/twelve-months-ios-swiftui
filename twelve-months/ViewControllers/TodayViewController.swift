//
//  TodayViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit
import CoreLocation

class TodayViewController: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var freshLabel: UILabel!
    @IBOutlet weak var storedLabel: UILabel!
    
    let month = Month.current
    let region = RegionType.current
    let foods = Bundle.main.decode([Food].self, from: "foods.json")
    var availableFresh = [String]()
    var availableStored = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthLabel.text = "\(month.rawValue)"
        regionLabel.text = "\(region.rawValue)"
        
        foods.forEach() { food in
            for available in food.availability {
                if let fresh = available.fresh {
                    if fresh.contains(month) {
                        availableFresh.append(food.name)
                    }
                }
                if let stored = available.stored {
                    if stored.contains(month) {
                        availableStored.append(food.name)
                    }
                }
            }
        }
        
        freshLabel.text = availableFresh.description
        storedLabel.text = availableStored.description
    }
    
}
