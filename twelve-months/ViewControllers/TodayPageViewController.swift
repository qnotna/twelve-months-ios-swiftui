//
//  TodayPageViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit

#warning("Page Control should wrap")
class TodayPageViewController: UIPageViewController {
    
    var todayDelegate: TodayPageViewControllerDelegate?
    var pages = [UIViewController]()
    var allFruits = [Food]()
    var allVegetables = [Food]()
    
    /// SegmentedControl as `navigationItem`
    lazy var foodTypeControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Vegetables", "Fruits"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(foodTypeDidChange(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
        
    //MARK: - PageViewController Initializers
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    //MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        dataSource = self
        allFruits = Bundle.main.decode([Food].self, from: "fruits.json")
        allVegetables = Bundle.main.decode([Food].self, from: "vegetables.json")
        createPages()
    }

    /// Set `foodTypeControl` as `navigationItem` and remove border from parent `navigationController`
    fileprivate func setupViews() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.titleView = foodTypeControl
    }
    
    /// Make `pageControl` transparent
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    /// Called by `foodTypeControl` when the value for `selectedSegmentIndex` changes
    @objc func foodTypeDidChange(_ segmentedControl: UISegmentedControl) {
        for page in pages {
            if let viewController = page.children.first as? MonthTableViewController {
                viewController.foodType.toggle()
            }
        }
    }
    
}

//MARK: UIPageViewControllerDelegate methods

extension TodayPageViewController {
    
    /// Tells the UIPageViewController which page should be displayed before the current page
    /// Calculates the index for the next page if a list overflow happens at the beginning of the pages list
    /// The index will wrap around if it is smaller than 0
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        var previousIndex = index - 1
        if previousIndex < 0 {
            previousIndex = pages.count - 1
        }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    /// Tells the UIPageViewController which page should be displayed after the current page
    /// Calculates the index for the next page if a list overflow happens at the end of the pages list
    /// The index will wrap around if it is equal to the last page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
        var nextIndex = index + 1
        let count = pages.count
        if count == nextIndex {
            nextIndex = 0
        }
        guard count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
    #warning("Always displays in dark mode")
    /// Tells the UIPageViewController how many pages should be displayed in the page view control at the bottom of the view
    /// - Parameter pageViewController: The page view controller.
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    /// Tells the UIPageViewController which page should be displayed highlighted in the page view control at the bottom of the view
    /// - Parameter pageViewController: The page view controller.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        Month.allCases.firstIndex(of: Month.current)!
    }
    
}

//MARK: Create pages

extension TodayPageViewController: UIPageViewControllerDataSource {
    
    /// Creates the page view controllers for the UIPageViewController
    /// Sets the `MonthViewController` for the `Month.current as the current page
    func createPages() {
        pages = createPageViewControllers()
        guard let firstMonthIndex = Month.allCases.firstIndex(of: Month.current) else { return }
        let currentViewController = pages[firstMonthIndex]
        setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
    }
    
    /// Instantiates each `MonthViewController` to be added as page to the `TodayPageViewController`
    /// Informs each `MonthViewController` as `TodayPageViewControllerDelegate` that data has been updated
    func createPageViewControllers() -> [UIViewController] {
        var pages = [UIViewController]()
        for month in Month.allCases {
            /// Create `monthTableViewController` with own `navigationController` for each `.month`
            let monthViewController = MonthTableViewController()
            let navigationController = UINavigationController(rootViewController: monthViewController)
            /// Add `navigationController` to `pages` and `prepareFoodItemData(for:from:)`
            pages.append(navigationController)
            let fruits = prepareFoodItemData(for: month, from: allFruits)
            let vegetables = prepareFoodItemData(for: month, from: allVegetables)
            /// Delegate page actions to each `monthViewController`
            todayDelegate = monthViewController
            todayDelegate!.pageView(didCreatePageFor: month, at: Month.allCases.firstIndex(of: month)!)
            todayDelegate!.pageView(didUpdate: vegetables, and: fruits)
        }
        return pages
    }
    
    //MARK: Data preparation and delegation
    
    #warning("Cultivation should not be sorted 'cultivation'>'import'>'ratio', instead sort by 'cultivation'>'ratio'>'import'")
    func prepareFoodItemData(for month: Month, from foodItems: [Food]?) -> Goods {
        var goods = Goods()
        let monthIndex = Month.allCases.firstIndex(of: month)!
        if let items = foodItems {
            /// Remove items without cultivation
            for item in items {
                if item.cultivationByMonth[monthIndex] != .none {
                    goods.cultivated.append(item)
                }
            }
            /// Remove all items wihout import and cultivation
            for item in items {
                if item.importByMonth[monthIndex] != .none && !goods.cultivated.contains(item) {
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
