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
    var fruits: Goods?
    var vegetables: Goods?
    
    #warning("Save default in 'UserDefaults' instead")
    var foodType: FoodType = .vegetable {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FoodCell.self, forCellReuseIdentifier: "FoodCell")
    }
    
    #warning("This should be a method on 'Goods', maybe overload subscript operator")
    func goods(in section: Int) -> [Food] {
        if let cultivatedVegetables = vegetables?.cultivated,
           let importedVegetables = vegetables?.imported,
           let cultivatedFruits = fruits?.cultivated,
           let importedFruits = fruits?.imported
        {
            switch OverviewSection(rawValue: section) {
            case .cultivation: return (foodType == .vegetable) ? cultivatedVegetables : cultivatedFruits
            case .importOnly:  return (foodType == .vegetable) ? importedVegetables   : importedFruits
            default: fatalError("Unexpectedly found illegal section \(section)")
            }
        }
        fatalError("Failed loading goods")
    }
    
}

//MARK: - TableViewControllerDelegate methods
    
extension MonthTableViewController {
    
    #warning("Missing edge case: no cultivation/imports in '.vegetables' or '.fruits'")
    /// Tells the tableViewController how many sections the table should have
    /// First section `.cultivation`, second section `.importOnly`
    override func numberOfSections(in tableView: UITableView) -> Int { OverviewSection.allCases.count }
    
    /// Tells the tableViewController what each section should be named
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(OverviewSection(rawValue: section)!)"
    }
    
    /// Tells the tableViewController how many rows each section in the table should have
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goods(in: section).count
    }
    
    /// Tells the tableViewController what each table cell should contain
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row,
            section = indexPath.section
        let item = goods(in: section)[row]
        switch OverviewSection(rawValue: section) {
        case .cultivation: return CultivationFoodCell(item, in: pageIndex!)
        case .importOnly:  return ImportFoodCell(item, in: pageIndex!)
        default: fatalError("Failed initializing FoodCell for section \(section)")
        }
    }
    
    //MARK: - Navigation
    
    /// Gets called whenever a cell has been tapped by the user
    /// Instaniates and adds the FoodItemViewController from the storyboard to the view hierarchy modally
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// Find `item` for `indexPath`
        let row = indexPath.row, section = indexPath.section
        let item = goods(in: section)[row]
        /// Present `FoodItemViewController` with `item`
        let tableViewController = FoodItemTableViewController(item: item,
                                                              in: pageIndex!,
                                                              at: indexPath,
                                                              from: OverviewSection(rawValue: section)!)
        let navigationController = UINavigationController(rootViewController: tableViewController)
        present(navigationController, animated: true)
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
