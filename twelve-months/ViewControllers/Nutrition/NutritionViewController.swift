//
//  NutritionViewController.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    var currentNutrition: String {
        switch overviewSegmentedControl.selectedSegmentIndex {
        case 0:
            return "currentVegetables"
        case 1:
            return "currentFruits"
        default:
            return "currentVegetables"
        }
    }


    @IBOutlet weak var overviewSegmentedControl: UISegmentedControl!
    
    var delegate: NutritionViewControllerDelegate?
    
    @IBAction func increaceCurrentNutritionValue(_ sender: UIBarButtonItem) {
        let newNutrationValue = defaults.double(forKey: currentNutrition) + 0.1
        defaults.set(newNutrationValue, forKey: currentNutrition)
        delegate?.currentNutritionValueChanged()
    }
    @IBAction func decreaseCurrentNutritionValue(_ sender: UIBarButtonItem) {
        let newNutrationValue = defaults.double(forKey: currentNutrition) - 0.1
        defaults.set(newNutrationValue, forKey: currentNutrition)
        delegate?.currentNutritionValueChanged()
    }
    
    @IBAction func segmentedControlChange(_ sender: UISegmentedControl) {
        delegate?.segmentedControl(didChange: sender.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nutritionTableView")
        self.delegate = tableViewController as! NutritionTableViewController
        
        self.delegate?.getSelectedSegmentIndex(overviewSegmentedControl.selectedSegmentIndex)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
