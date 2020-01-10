//
//  MonthTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class MonthTableViewController: UITableViewController {
    
    var pageIndex: Int?
    var indexPath: IndexPath?
    var fruits: (cultivated: [Food], imported: [Food])?
    var vegetables: (cultivated: [Food], imported: [Food])?
    var foodType: FoodType = .vegetable {
        didSet {
            tableView.reloadData()
        }
    }
    //    var fruits: [Food]?
    //    var vegetables: [Food]?
    
    //MARK: TableViewControllerDelegate methods
    
    /// Tells the tableViewController how many sections the table should have
    /// It returns 2: one for fresh, one for stored
    /// - Parameter tableView: An object representing the table view requesting this information.
    override func numberOfSections(in tableView: UITableView) -> Int {
        if fruits!.imported.count == 0 || vegetables!.imported.count == 0 {
            return 1
        }
        return 2
    }
    
    /// Tells the tableViewController what each section should be named
    /// - Parameters:
    ///   - tableView: The table-view object asking for the title.
    ///   - section: An index number identifying a section of tableView .
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Cultivation" : "Import Only"
    }
    
    /// Tells the tableViewController how many rows each section in the table should have
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section in tableView.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodType == .vegetable {
            return (section == 0 ? vegetables?.cultivated.count : vegetables?.imported.count)!
        }
        return (section == 0 ? fruits?.cultivated.count : fruits?.imported.count)!
    }
    
    /// Tells the tableViewController what each table cell should contain
    /// - Parameters:
    ///   - tableView: A table-view object requesting the cell.
    ///   - indexPath: An index path locating a row in tableView.
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
    
    /// Gets called whenever a cell has been tapped by the user
    /// Whenever this happens, the FoodItemViewControllerSegue will be performed with the current food item as sender.
    /// This adds the FoodItemViewController to the view hierarchy modally
    /// - Parameters:
    ///   - tableView: A table-view object informing the delegate about the new row selection.
    ///   - indexPath: An index path locating the new selected row in tableView.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vegetables = vegetables, let fruits = fruits {//}, let foodType = foodType {
            var item: Food?
            if indexPath.section == 0 {
                item = foodType == .vegetable ? vegetables.cultivated[indexPath.row] : fruits.cultivated[indexPath.row]
            } else {
                item = foodType == .vegetable ? vegetables.imported[indexPath.row] : fruits.imported[indexPath.row]
            }
            self.indexPath = indexPath
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
                destination.indexPath = indexPath
                destination.pageIndex = pageIndex
            }
        default:
            return
        }
    }

}

//MARK: Updating Data

extension MonthTableViewController: TodayPageViewControllerDelegate {
    
    func pageView(didUpdatePageFor month: Month, pageIndex: Int, foodType: FoodType) {
        self.title = month.rawValue
        self.pageIndex = pageIndex
//        self.foodType = foodType
    }

    /// Delegate method from TodayPageViewControllerDelegate
    /// Receives updated month and food data and sets it to MonthTableViewController
    /// - Parameters:
    ///   - month: the received month
    ///   - food: the received food for this month
    func pageView(didUpdateFruitsData fruits: (cultivated: [Food], imported: [Food])) {
        self.fruits = fruits
    }
    
    func pageView(didUpdateVegetablesData vegetables: (cultivated: [Food], imported: [Food])) {
        self.vegetables = vegetables
    }
    
    func pageView(segmentedControlDidChange index: Int) {
        self.foodType = index == 0 ? .vegetable : .fruit
    }
    
}
