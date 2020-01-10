//
//  NutritionTableViewController.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class NutritionTableViewController: UITableViewController, NutritionViewControllerDelegate {
    
    var currentNutrition: String {
        switch selectedIndex {
        case 0:
            return "currentVegetables"
        case 1:
            return "currentFruits"
        default:
            return "currentVegetables"
        }
    }
    
    func currentNutritionValueChanged() {
        loadData(forNutitionIndex: selectedIndex ?? 1)
        print(dailyProgress)
    }
    
    @IBAction func increaceCurrentNutritionValue(_ sender: UIButton) {
        var newNutrationValue = defaults.double(forKey: currentNutrition) + 0.5
        newNutrationValue = Double(round(10*newNutrationValue)/10)
        defaults.set(newNutrationValue, forKey: currentNutrition)
        loadData(forNutitionIndex: selectedIndex ?? 0)
        setDailyData()
    }
    
    @IBAction func decreaseCurrentNutritionValue(_ sender: UIButton) {
        var newNutrationValue = defaults.double(forKey: currentNutrition) - 0.5
        newNutrationValue = Double(round(10*newNutrationValue)/10)
        if (newNutrationValue >= 0){
            defaults.set(newNutrationValue, forKey: currentNutrition)
            loadData(forNutitionIndex: selectedIndex ?? 0)
            setDailyData()
        }
    }
    
    let defaults = UserDefaults.standard
   
    var selectedIndex: Int?
    
    func getSelectedSegmentIndex(_ index: Int) {
        selectedIndex = index
    }
    
    func segmentedControl(didChange index: Int) {
        selectedIndex = index
    }
    
    var dailyProgress: NutritionProgress?
    var weeklyProgress = [NutritionProgress]()

    
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet var dailyAmountLabel: UILabel!
    @IBOutlet weak var dailyPercentageLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Hello! Will appear")
        loadData(forNutitionIndex: selectedIndex ?? 0)
        setDailyData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello! Did load")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setDailyData(){
        print(dailyProgress!.goalValue)
        let current = dailyProgress!.currentValue
        let goal = dailyProgress!.goalValue
        dailyAmountLabel.text = String(format: "%0.1f / %0.1f c", current, goal)
        
        circularProgress.angle = dailyProgress!.progress * 360
        
        dailyPercentageLabel.text = String(format: "%.0f%%", (dailyProgress!.progress * 100))
    }
    
    func loadData(forNutitionIndex index: Int){
        var nData: NutritionData
        var currentNutrition: Double
        switch index {
        case 0:
            nData = EatingPatterns.getVegetableAmount(calories: defaults.double(forKey: "kcal"))
            currentNutrition = defaults.double(forKey: "currentVegetables")
        case 1:
           nData = EatingPatterns.getFruitAmount(calories: defaults.double(forKey: "kcal"))
            currentNutrition = defaults.double(forKey: "currentFruits")
        default:
            nData = EatingPatterns.getVegetableAmount(calories: defaults.double(forKey: "kcal"))
            currentNutrition = defaults.double(forKey: "currentVegetables")
        }
        
        dailyProgress = NutritionProgress(
            name: "Daily",
            isMain: false,
            currentValue: currentNutrition,
            goalValue: nData.dailyAmount
        )
        for goal in nData.goals {
            weeklyProgress.append(NutritionProgress(
                name: goal.name,
                isMain: goal.type == GoalTypes.DAILY,
                currentValue: 0,
                goalValue: goal.value
            ))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 2 : weeklyProgress.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        return cell
//    }

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
