//
//  MonthTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class MonthTableViewController: UITableViewController {
    
    weak var coordinator: MainCoordinator?
    
    var fruits: Goods!
    var vegetables: Goods!
    var month: Int!
    #warning("Save default in 'UserDefaults' instead")
    var foodType: FoodType = .vegetable {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    init(_ goods: (vegetables: Goods, fruits: Goods), for month: Month) {
        super.init(style: .insetGrouped)
        /// Inset `tableView` to be visible under `TodayPageViewController.foodTypeControl`
        tableView.contentInset.bottom = 65
        vegetables = goods.vegetables
        fruits = goods.fruits
        self.month = Month.allCases.firstIndex(of: month)!
        #warning("Is this the best way?")
        title = month.rawValue
        tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

//MARK: - Delegate+DataSource

#warning("Move to 'MonthDataSource'")
extension MonthTableViewController {
    
    func goods(in section: Int) -> [Food] {
        let cultivatedVegetables = vegetables.cultivated,
            importedVegetables = vegetables.imported,
            cultivatedFruits = fruits.cultivated,
            importedFruits = fruits.imported
        switch OverviewSection(rawValue: section) {
        case .cultivation: return (foodType == .vegetable) ? cultivatedVegetables : cultivatedFruits
        case .importOnly:  return (foodType == .vegetable) ? importedVegetables   : importedFruits
        default: fatalError("Unexpectedly found illegal section \(section)")
        }
    }
    
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
        case .cultivation: return CultivationFoodCell(item, in: month)
        case .importOnly:  return ImportFoodCell(item, in: month)
        default: fatalError("Failed initializing FoodCell for section \(section)")
        }
    }
    
    /// Gets called whenever a cell has been tapped by the user
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// Find `item` for `indexPath`
        let row = indexPath.row, section = indexPath.section
        let item = goods(in: section)[row]
        /// Present `FoodItemViewController` with `item`
        coordinator?.instantiateFoodItemTableViewController(for: item, from: section, on: self)
    }
    
}
