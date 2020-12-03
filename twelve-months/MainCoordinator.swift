//
//  MainCoordinator.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 26.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

/// Responsible for navigation and handling viewControllers
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var monthViewControllers: [UIViewController]

    #warning("Create datasource instead")
    private var allVegetables: [Food]
    private var allFruits: [Food]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        #warning("SafeArea should not be transparent")
        self.navigationController.isNavigationBarHidden = true
        monthViewControllers = [UIViewController]()
        allVegetables = Bundle.main.decode([Food].self, from: Food.vegetablesUrl)
        allFruits = Bundle.main.decode([Food].self, from: Food.fruitsUrl)
    }

    // MARK: - ViewController Instantiation

    /// Entry point
    func start() {
        instantiateMonthNavigationViewControllers()
        instantiateTodayPageViewController()
    }

    /// Create `todayViewController` and embed in a `navigationController`
    func instantiateTodayPageViewController() {
        let viewController = TodayPageViewController(pages: monthViewControllers)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }

    /// Create a `navigationController` with `monthViewController` for each `month`
    func instantiateMonthNavigationViewControllers() {
        for month in Month.allCases {
            let vegetables = prepareData(for: month, from: allVegetables)
            let fruits = prepareData(for: month, from: allFruits)
            let monthViewController = MonthTableViewController((vegetables: vegetables, fruits: fruits),
                                                               for: month)
            monthViewController.coordinator = self
            monthViewControllers.append(monthViewController)
        }
    }

    /// Present `foodItemTableViewController` with `item` on `viewController` modally
    func instantiateFoodItemTableViewController(for item: Food,
                                                from section: Int,
                                                on viewController: MonthTableViewController) {
        let foodItemTableViewController = FoodItemTableViewController(item: item,
                                                                      at: viewController.month,
                                                                      from: section)
        foodItemTableViewController.coordiantor = self
        let navigationController = UINavigationController(rootViewController: foodItemTableViewController)
        viewController.present(navigationController, animated: true)
    }

    /// Dismisses a presented `viewController` and removes it from the view hierarchy
    func dismissViewController(_ viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }

    // MARK: - DataSource

    #warning("Do this in 'MonthDataSource'")
    #warning("Enable user sorting")
    private func prepareData(for month: Month, from foodItems: [Food]?) -> Goods {
        var goods = Goods()
        let monthIndex = Month.allCases.firstIndex(of: month)!
        if let items = foodItems {
            for item in items {
                /// Remove items without cultivation
                if item.cultivationByMonth[monthIndex] != .none {
                    goods.cultivated.append(item)
                }
                /// Remove all items wihout import and cultivation
                if item.importByMonth[monthIndex] != .none, !goods.cultivated.contains(item) {
                    goods.imported.append(item)
                }
            }
        }
        /// Sort cultivated goods
        goods.cultivated = goods.cultivated.sorted { (lhs, rhs) -> Bool in
            if lhs.cultivationByMonth[monthIndex].rawValue == rhs.cultivationByMonth[monthIndex].rawValue {
                if lhs.ratio![monthIndex] == rhs.ratio![monthIndex] {
                    return lhs.name > rhs.name
                }
                return lhs.ratio![monthIndex] > rhs.ratio![monthIndex]
            }
            return lhs.cultivationByMonth[monthIndex].rawValue > rhs.cultivationByMonth[monthIndex].rawValue
        }
        /// Sort imported goods
        goods.imported = goods.imported.sorted { (lhs, rhs) -> Bool in
            if lhs.importByMonth[monthIndex].rawValue == rhs.importByMonth[monthIndex].rawValue {
                return lhs.name < rhs.name
            }
            return lhs.importByMonth[monthIndex].rawValue < rhs.importByMonth[monthIndex].rawValue
        }
        return goods
    }
}
