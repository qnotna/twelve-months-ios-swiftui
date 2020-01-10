//
//  MonthTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class MonthTableViewController: UITableViewController {
    
    var month: Month?
    var fruits: [Food]?
    var vegetables: [Food]?
    var foodType: FoodType?
    
    func color(for availability: Availability) -> UIColor {
        var color: UIColor?
        switch availability {
        case .highest:
            color = UIColor.green
        case .high:
            color = UIColor.yellow
            break
        case .low:
            color = UIColor.orange
        case .lowest:
            color = UIColor.red
        default:
            color = UIColor.clear
        }
        return color!
    }
            
    //MARK: TableViewControllerDelegate methods
    
    /// Tells the tableViewController how many sections the table should have
    /// It returns 2: one for fresh, one for stored
    /// - Parameter tableView: An object representing the table view requesting this information.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Tells the tableViewController what each section should be named
    /// - Parameters:
    ///   - tableView: The table-view object asking for the title.
    ///   - section: An index number identifying a section of tableView .
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let foodType = foodType {
            return foodType == .vegetable ? FoodType.vegetable.rawValue : FoodType.fruit.rawValue
        }
        return nil
    }
    
    /// Tells the tableViewController how many rows each section in the table should have
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section in tableView.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let vegetables = vegetables, let fruits = fruits, let foodType = foodType {
            return foodType == .vegetable ? vegetables.count : fruits.count
        }
        return 1
    }
    
    /// Tells the tableViewController what each table cell should contain
    /// - Parameters:
    ///   - tableView: A table-view object requesting the cell.
    ///   - indexPath: An index path locating a row in tableView.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodItemTableViewCell") as! FoodItemTableViewCell
        if let vegetables = vegetables, let fruits = fruits, let foodType = foodType {
            let item = foodType == .vegetable ? vegetables[indexPath.row] : fruits[indexPath.row]
            cell.nameLabel.text = item.name.capitalized
            cell.availabilityTrafficLight.backgroundColor = color(for: item.cultivationByMonth[0])
        } else {
            cell.nameLabel.text = "Nothing to See Here 👀"
        }
        return cell
    }
    
    /// Gets called whenever a cell has been tapped by the user
    /// Whenever this happens, the FoodItemViewControllerSegue will be performed with the current food item as sender.
    /// This adds the FoodItemViewController to the view hierarchy modally
    /// - Parameters:
    ///   - tableView: A table-view object informing the delegate about the new row selection.
    ///   - indexPath: An index path locating the new selected row in tableView.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vegetables = vegetables, let fruits = fruits, let foodType = foodType {
            let item = foodType == .vegetable ? vegetables[indexPath.row] : fruits[indexPath.row]
            performSegue(withIdentifier: StoryBoardSegueIdentifier.monthToFoodItem.rawValue, sender: item)
        }
    }
    
    /// If a segue is initiated, this method will be called
    /// It checks which identifier the segue has
    /// It sets the received sender object on the viewController on the other and of the segue
    /// - Parameters:
    ///   - segue: The segue object containing information about the view controllers involved in the segue.
    ///   - sender: The food item that was passed in as sender when tableView(_:_, didSelectRowAt _:_) was called
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case StoryBoardSegueIdentifier.monthToFoodItem.rawValue:
            if let destination = segue.destination as? FoodItemViewController {
                destination.item = sender as? Food
            }
        default:
            return
        }
    }

}

//MARK: Updating Data

extension MonthTableViewController: TodayPageViewControllerDelegate {
    
    /// Delegate method from TodayPageViewControllerDelegate
    /// Receives updated month and food data and sets it to MonthTableViewController
    /// - Parameters:
    ///   - month: the received month
    ///   - food: the received food for this month
    func pageView(didUpdateChildrenViewControllerDataFor month: Month, with fruits: [Food], and vegetables: [Food]) {
        self.title = month.rawValue
        self.month = month
        var sortedFruits = sortByAvailability(list: fruits)
        self.fruits = sortedFruits//removeUncultivated(from: sortedFruits)
        var sortedVegetables = sortByAvailability(list: vegetables)
        self.vegetables = sortedVegetables//removeUncultivated(from: sortedVegetables)
        self.foodType = .vegetable
//        tableView.reloadData()
    }
    
    func pageView(segmentedControlDidChange index: Int) {
        self.foodType = index == 0 ? .vegetable : .fruit
//        tableView.reloadData()
    }
    
    func removeUncultivated(from list: [Food]) -> [Food] {
        return list.filter{$0.cultivationByMonth[0] != .none}
    }
    
    func sortByAvailability(list: [Food]) -> [Food] {
        return list.sorted{$0.cultivationByMonth[0].rawValue > $1.cultivationByMonth[0].rawValue}
    }
    
}
