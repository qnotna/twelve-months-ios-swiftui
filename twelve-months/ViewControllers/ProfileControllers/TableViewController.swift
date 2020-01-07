//
//  TableViewController.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 06.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    
    // MARK: User input
    var gender: Int { defaults.integer(forKey: "gender") }
    var height: Int { defaults.integer(forKey: "height") }
    var weight: Int { defaults.integer(forKey: "weight") }
    var age: Int { defaults.integer(forKey: "age") }
    
    // MARK: Calories calculation
    var kcal: Double { Calories.calculateCalories(gender: gender, height: height, weight: weight, age: age, activityMultiplier: 1.2) }
    
    // MARK: Vegetable data
    var vData: VegetableData { EatingPatterns.getVegetableAmount(calories: kcal) }
    
    // MARK: Fruit data
    var fData: FruitData { EatingPatterns.getFruitAmount(calories: kcal) }

    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var widthInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var vegetablesAmountLabel: UILabel!
    @IBOutlet weak var vegetablesPortionsLabel: UILabel!
    
    @IBOutlet weak var fruitsAmountLabel: UILabel!
    @IBOutlet weak var fruitsPortionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderSegmentedControl.selectedSegmentIndex = gender
        heightInput.text = String(height)
        widthInput.text = String(weight)
        ageInput.text = String(age)
        caloriesLabel.text = String(format: "%0.f kcal", kcal)
        updateVegetables(self)
        updateFruits(self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func updateCalories(_ sender: Any) {
        caloriesLabel.text = String(format: "%0.f kcal", kcal)
    }
    
    @IBAction func updateVegetables(_ sender: Any) {
        let amountFormat = vData.amount == floor(vData.amount) ? "%0.f c" : "%.1f c"
        vegetablesAmountLabel.text = String(format: amountFormat, vData.amount)
        vegetablesPortionsLabel.text = String(format: "%0.f portions", vData.portions)
    }
    
    @IBAction func updateFruits(_ sender: Any) {
        print(fData)
        let amountFormat = fData.amount == floor(fData.amount) ? "%0.f c" : "%.1f c"
        fruitsAmountLabel.text = String(format: amountFormat, fData.amount)
        fruitsPortionsLabel.text = String(format: "%0.f portions", fData.portions)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 5 : 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
