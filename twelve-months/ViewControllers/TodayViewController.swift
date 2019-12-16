//
//  TodayViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plants = Bundle.main.decode([Plant].self, from: "plants.json")
        let countries = Bundle.main.decode([Country].self, from: "countries.json")
    }

}
