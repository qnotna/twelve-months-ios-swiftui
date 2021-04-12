//
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

/// Holds categorized vegetables and fruits
typealias CategorizedFoodPair = (vegetables: CategorizedFood, fruits: CategorizedFood)

class MonthTableViewController: UITableViewController {
    weak var coordinator: MainCoordinator?
    var fruits: CategorizedFood!
    var vegetables: CategorizedFood!
    var month: Month!

    #warning("Save default in 'UserDefaults' instead")
    var foodType: FoodType = .vegetable {
        didSet {
            tableView.reloadData()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }

    // MARK: - Lifecycle

    init(categorized pair: CategorizedFoodPair, for month: Month) {
        super.init(style: .insetGrouped)
        vegetables = pair.vegetables
        fruits = pair.fruits
        self.month = month
        title = month.rawValue
        tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
        /// Inset `tableView` to be visible under `TodayPageViewController.foodTypeControl`
        tableView.contentInset.bottom = 65
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Delegate & DataSource

#warning("Move to 'MonthDataSource'")
extension MonthTableViewController {
    func goods(in section: Int) -> [Food] {
        let availabilityType = AvailabilityType(rawValue: section)
        switch (availabilityType, foodType) {
        case (.cultivation, .vegetable): return vegetables.cultivated
        case (.cultivation, .fruit):     return fruits.cultivated
        case (.importOnly, .vegetable):  return vegetables.imported
        case (.importOnly, .fruit):      return fruits.imported
        default:                         fatalError("Unexpectedly found illegal section \(section)")
        }
    }

    #warning("Missing edge case: no cultivation/imports in '.vegetables' or '.fruits'")
    /// Tells the tableViewController how many sections the table should have
    /// First section `.cultivation`, second section `.importOnly`
    override func numberOfSections(in _: UITableView) -> Int { AvailabilityType.allCases.count }

    /// Tells the tableViewController what each section should be named
    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        AvailabilityType(rawValue: section)?.description
    }

    /// Tells the tableViewController how many rows each section in the table should have
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        goods(in: section).count
    }

    /// Tells the tableViewController what each table cell should contain
    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row,
            section = indexPath.section
        let item = goods(in: section)[row]
        switch AvailabilityType(rawValue: section) {
        case .cultivation: return CultivationFoodCell(item, in: month)
        case .importOnly:  return ImportFoodCell(item, in: month)
        default:           fatalError("Failed initializing FoodCell for section \(section)")
        }
    }

    /// Gets called whenever a cell has been tapped by the user
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// Find `item` for `indexPath`
        let row = indexPath.row, section = indexPath.section
        let item = goods(in: section)[row]
        /// Present `FoodItemViewController` with `item`
        coordinator?.presentDetail(for: item, from: section, on: self)
    }
}
