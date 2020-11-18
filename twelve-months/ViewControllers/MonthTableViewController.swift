//
//  MonthTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

#warning("Scrolling is sometimes irresponsive due to segmented control in navigation bar")
class MonthTableViewController: UITableViewController {
    
    var pageIndex: Int?
    var indexPath: IndexPath?
    var fruits: Goods?
    var vegetables: Goods?
    var foodType: FoodType = .vegetable {
        didSet {
            tableView.reloadData()
        }
    }
    
    /// Toggles `foodType` between `.vegetable` and `.fruit` depending on which is currently stored in the variable
    func toggleFoodType() {
        self.foodType = self.foodType == .vegetable ? .fruit : .vegetable
    }
    
}

//MARK: - TableViewControllerDelegate methods
    
extension MonthTableViewController {
    
    /// Tells the tableViewController how many sections the table should have
    /// It returns 2: one for fresh, one for stored
    override func numberOfSections(in tableView: UITableView) -> Int {
        if fruits!.imported.count == 0 || vegetables!.imported.count == 0 {
            return 1
        }
        return 2
    }
    
    /// Tells the tableViewController what each section should be named
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == AvailabilitySection.cultivation.rawValue ? "Cultivation" : "Import Only"
    }
    
    /// Tells the tableViewController how many rows each section in the table should have
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodType == .vegetable {
            return (section == AvailabilitySection.cultivation.rawValue ? vegetables?.cultivated.count : vegetables?.imported.count)!
        }
        return (section == AvailabilitySection.cultivation.rawValue ? fruits?.cultivated.count : fruits?.imported.count)!
    }
    
    /// Tells the tableViewController what each table cell should contain
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodItemTableViewCell") as! FoodItemTableViewCell
        cell.pageIndex = pageIndex
        if foodType == .vegetable {
            cell.populate(from: vegetables!, at: indexPath)
        } else {
            cell.populate(from: fruits!, at: indexPath)
        }
        return cell
    }
    
    //MARK: - Navigation
    
    /// Gets called whenever a cell has been tapped by the user
    /// Whenever this happens, the FoodItemViewControllerSegue will be performed with the current food item as sender.
    /// This adds the FoodItemViewController to the view hierarchy modally
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vegetables = vegetables, let fruits = fruits {
            var item: Food?
            if indexPath.section == AvailabilitySection.cultivation.rawValue {
                item = foodType == .vegetable ? vegetables.cultivated[indexPath.row] : fruits.cultivated[indexPath.row]
            } else {
                item = foodType == .vegetable ? vegetables.imported[indexPath.row] : fruits.imported[indexPath.row]
            }
            self.indexPath = indexPath
            performSegue(withIdentifier: SegueIdentifier.monthToFoodItem.rawValue, sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FoodItemViewController {
            destination.item = sender as? Food
            destination.indexPath = indexPath
            destination.pageIndex = pageIndex
            
        }
    }

}

//MARK: - Updating Data

extension MonthTableViewController: TodayPageViewControllerDelegate {
    
    func pageView(didCreatePageFor month: Month, at pageIndex: Int) {
        self.title = month.rawValue
        self.pageIndex = pageIndex
    }

    func pageView(didUpdate vegetables: Goods, and fruits: Goods) {
        self.vegetables = vegetables
        self.fruits = fruits
    }
        
}
