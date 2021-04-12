//
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

/// Responsible for navigation and handling view controllers
class MainCoordinator: Coordinator {
    /// The main navigation controller
    var navigationController: RootController
    /// List of all 12 months view controllers
    var monthViewControllers = [MonthTableViewController]()

    #warning("Create datasource instead")
    /// Vegetable datasource
    private var vegetables: [Food]
    /// Fruits datasource
    private var fruits: [Food]

    init(navigationController: RootController) {
        self.navigationController = navigationController
        #warning("SafeArea should not be transparent")
        vegetables = Bundle.main.decode([Food].self, from: Food.vegetablesUrl)
        fruits = Bundle.main.decode([Food].self, from: Food.fruitsUrl)
    }

    // MARK: - ViewController Instantiation

    /// Entry point
    func start() {
        createPages()
        addPages()
    }

    /// Create a `monthViewController` for each `month`
    func createPages() {
        Month.allCases.forEach { month in
            let preparedVegetables = prepareData(for: month, from: vegetables)
            let preparedFruits = prepareData(for: month, from: fruits)
            let pair: CategorizedFoodPair = (vegetables: preparedVegetables, fruits: preparedFruits)
            let viewController = MonthTableViewController(categorized: pair, for: month)
            viewController.coordinator = self
            monthViewControllers.append(viewController)
        }
    }

    /// Create `todayViewController` and embed in the main `navigationController`
    func addPages() {
        let viewController = TodayPageViewController(pages: monthViewControllers)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }

    /// Present `foodItemTableViewController` with `item` on `viewController` modally
    func presentDetail(for item: Food, from section: Int, on presentingViewController: MonthTableViewController) {
        let viewController = FoodTableViewController(item: item, at: presentingViewController.month, from: section)
        viewController.coordinator = self
        let navigationController = UINavigationController(rootViewController: viewController)
        presentingViewController.present(navigationController, animated: true)
    }

    /// Dismisses a presented `viewController` and removes it from the view hierarchy
    func dismiss(_ viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }

    // MARK: - DataSource

    /// Prepare `Food` by sorting and creating `CategorizedFood`
    /// - Parameters:
    ///   - month: the month for which the data should be prepared
    ///   - foodItems: the items to be prepared
    /// - Returns: the goods for this month
    private func prepareData(for month: Month, from foodItems: [Food]?) -> CategorizedFood {
        #warning("Do this in 'MonthDataSource'")
        #warning("Enable user sorting")
        var categorized = CategorizedFood()
        let index = Month.index(of: month)
        if let items = foodItems {
            items.forEach { item in
                /// Remove items without cultivation
                if item.cultivationByMonth[index] != .none {
                    categorized.cultivated.append(item)
                }
                /// Remove all items without import and cultivation
                if item.importByMonth[index] != .none, !categorized.cultivated.contains(item) {
                    categorized.imported.append(item)
                }
            }
        }
        /// Sort cultivated goods
        categorized.cultivated = categorized.cultivated.sorted { (lhs, rhs) -> Bool in
            if lhs.cultivationByMonth[index].rawValue == rhs.cultivationByMonth[index].rawValue {
                if lhs.ratio![index] == rhs.ratio![index] {
                    return lhs.name > rhs.name
                }
                return lhs.ratio![index] > rhs.ratio![index]
            }
            return lhs.cultivationByMonth[index].rawValue > rhs.cultivationByMonth[index].rawValue
        }
        /// Sort imported goods
        categorized.imported = categorized.imported.sorted { (lhs, rhs) -> Bool in
            if lhs.importByMonth[index].rawValue == rhs.importByMonth[index].rawValue {
                return lhs.name < rhs.name
            }
            return lhs.importByMonth[index].rawValue < rhs.importByMonth[index].rawValue
        }
        return categorized
    }
}
