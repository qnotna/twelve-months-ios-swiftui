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
    var fruits: Goods?
    var vegetables: Goods?
    
    #warning("Save default in 'UserDefaults' instead")
    var foodType: FoodType = .vegetable {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let cellReuseIdentifier = "FoodCell"
    
    /// Toggles `foodType` between `.vegetable` and `.fruit` depending on which is currently stored in the variable
    func toggleFoodType() {
        self.foodType = self.foodType == .vegetable ? .fruit : .vegetable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FoodCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "\(Section(rawValue: section)!)" }
    
    /// Tells the tableViewController how many rows each section in the table should have
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
            case .cultivation:
                if foodType == .vegetable {
                    return vegetables!.cultivated.count
                } else {
                    return fruits!.cultivated.count
                }
            case .importOnly:
                if foodType == .fruit {
                    return vegetables!.imported.count
                } else {
                    return fruits!.imported.count
                }
            default: fatalError("Found invalid section \(section)")
        }
    }
    
    /// Tells the tableViewController what each table cell should contain
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FoodCell?
        switch Section(rawValue: indexPath.section) {
        case .cultivation:
            /// Setup `cell` as `CultivationFoodCell`
            cell = CultivationFoodCell(reuseIdentifier: cellReuseIdentifier)
            cell?.month = pageIndex
            if foodType == .vegetable {
                cell?.setup(vegetables!.cultivated[indexPath.row])
            } else {
                cell?.setup(vegetables!.cultivated[indexPath.row])
            }
        case .importOnly:
            /// Setup `cell` as `ImportFoodCell`
            cell = ImportFoodCell(reuseIdentifier: cellReuseIdentifier)
            cell?.month = pageIndex
            if foodType == .fruit {
                cell?.setup(fruits!.imported[indexPath.row])
            } else {
                cell?.setup(fruits!.imported[indexPath.row])
            }
        default: fatalError("Found invalid section \(indexPath.section)")
        }
        return cell!
    }
    
    //MARK: - Navigation
    
    /// Gets called whenever a cell has been tapped by the user
    /// Instaniates and adds the FoodItemViewController from the storyboard to the view hierarchy modally
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vegetables = vegetables, let fruits = fruits {
            /// Determine `item`
            var item: Food?
            switch Section(rawValue: indexPath.section) {
            case .cultivation:
                item = foodType == .vegetable ? vegetables.cultivated[indexPath.row] : fruits.cultivated[indexPath.row]
            case .importOnly:
                item = foodType == .vegetable ? vegetables.imported[indexPath.row] : fruits.imported[indexPath.row]
            default: fatalError("Found invalid section \(indexPath.section)")
            }
            self.indexPath = indexPath
            /// Present `FoodItemViewController` with `item`
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(identifier: "FoodItemViewController") as? FoodItemViewController {
                viewController.item = item
                viewController.indexPath = indexPath
                viewController.pageIndex = pageIndex
                present(viewController, animated: true)
            }
        }
    }

}

//MARK: - Updating Data

extension MonthTableViewController: TodayPageViewControllerDelegate {
    
    func pageView(didCreatePageFor month: Month, at pageIndex: Int) {
        title = month.rawValue
        self.pageIndex = pageIndex
    }

    func pageView(didUpdate vegetables: Goods, and fruits: Goods) {
        self.vegetables = vegetables
        self.fruits = fruits
    }
        
}
