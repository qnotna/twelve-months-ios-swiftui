//
//  TodayPageViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit
import CoreLocation

class TodayPageViewController: UIPageViewController {
    
    var todayDelegate: TodayPageViewControllerDelegate?
    var pages: [UIViewController]?
    let months: [Month] = [.january, .february, .march, .april, .may, .june, .july, .august, .september, .october, .november, .december]
    var allFruits: [Food]?
    var allVegetables: [Food]?
    
    //MARK: IBActions
    
    @IBAction func foodTypeDidChange(_ sender: UISegmentedControl) {
//        for monthViewController in pages! {
//            todayDelegate = monthViewController as? TodayPageViewControllerDelegate
            todayDelegate?.pageView(segmentedControlDidChange: sender.selectedSegmentIndex)
//        }
//        NotificationCenter.default.post(name: .foodTypeDidChange, object: nil)
    }
    
    //MARK: UIPageViewControllerDelegate methods
    
    /// Tells the UIPageViewController which page should be displayed before the current page
    /// Calculates the index for the next page if a list overflow happens at the beginning of the pages list
    /// The index will wrap around if it is smaller than 0
    /// - Parameters:
    ///   - pageViewController: The page view controller
    ///   - viewController: The view controller that the user navigated away from.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("previous")
        guard let index = pages?.firstIndex(of: viewController) else {
            return nil
        }
        var previousIndex = index - 1
        if previousIndex < 0 {
            previousIndex = pages!.count - 1
        }
        guard pages!.count > previousIndex else {
            return nil
        }
        return pages?[previousIndex]
    }
    
    /// Tells the UIPageViewController which page should be displayed after the current page
    /// Calculates the index for the next page if a list overflow happens at the end of the pages list
    /// The index will wrap around if it is equal to the last page
    /// - Parameters:
    ///   - pageViewController: The page view controller
    ///   - viewController: The view controller that the user navigated away from.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages?.firstIndex(of: viewController) else {
            return nil
        }
        var nextIndex = index + 1
        let count = pages?.count
        if count == nextIndex {
            nextIndex = 0
        }
        guard count! > nextIndex else {
            return nil
        }
        return pages?[nextIndex]
    }
        
    /// Tells the UIPageViewController how many pages should be displayed in the page view control at the bottom of the view
    /// - Parameter pageViewController: The page view controller.
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages!.count  //TODO: always displays in dark mode
    }
    
    /// Tells the UIPageViewController which page should be displayed highlighted in the page view control at the bottom of the view
    /// - Parameter pageViewController: The page view controller.
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return months.firstIndex(of: Month.current)! //TODO: can not be changed by user interaction
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for view in view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            }else if view is UIPageControl{
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
}

//MARK: Create pages

extension TodayPageViewController: UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        dataSource = self
        allFruits = Bundle.main.decode([Food].self, from: "fruits.json")
        allVegetables = Bundle.main.decode([Food].self, from: "vegetables.json")
        createPages()
    }
    
    /// Creates the page view controllers for the UIPageViewController
    /// Sets a MonthViewController as the current page
    /// - Parameters:
    ///   - fruits: list of decoded fruits
    ///   - vegetables: list of decoded vegetables
    func createPages() {
        pages = createPageViewControllers()
        if let currentViewController = pages?.first { //TODO: always displays january as first page
            setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    /// Instantiates each MonthViewController to be added as Page to the UIPageViewController
    /// Creates the view controllers from the storyboard without segue
    /// Informs each MonthViewController as TodayPageViewControllerDelegate that data has been updated
    /// - Parameters:
    ///   - months: all months
    ///   - fruits: list of decoded fruits
    ///   - vegetables: list of decoded vegetables
    /// - Returns: a list of all MonthViewControllers
    func createPageViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        for month in months {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MonthNavigationViewController")
            viewControllers.append(viewController)

            let fruits = prepareFoodItemData(for: month, from: allFruits)
            let vegetables = prepareFoodItemData(for: month, from: allVegetables)
            if let monthViewController = viewController.children.first {
//            for monthViewController in viewControllers {
                todayDelegate = monthViewController as? TodayPageViewControllerDelegate
                todayDelegate?.pageView(didUpdatePageFor: month, pageIndex: months.firstIndex(of: month)!, foodType: .vegetable)
                todayDelegate?.pageView(didUpdateFruitsData: fruits)
                todayDelegate?.pageView(didUpdateVegetablesData: vegetables)
            }
        }
        return viewControllers
    }
    
    //MARK: Data preparation and delegation
    
    func prepareFoodItemData(for month: Month, from foodItems: [Food]?) -> (cultivated: [Food], imported: [Food]) {
        var food = (cultivated: [Food](), imported: [Food]())
        let monthIndex = months.firstIndex(of: month)!
        if let items = foodItems {
//            for item in items {
//                fetchImage()
//            }
            for item in items {
                if item.cultivationByMonth[monthIndex] != .none {
                    food.cultivated.append(item)
                }
            }
            for item in items {
                if item.importByMonth[monthIndex] != .none && !food.cultivated.contains(item) {
                    food.imported.append(item)
                }
            }
        }
        food.cultivated = food.cultivated.sorted() { (lhs, rhs) -> Bool in
            if lhs.cultivationByMonth[monthIndex].rawValue == rhs.cultivationByMonth[monthIndex].rawValue {
                if lhs.percentagePerMonth![monthIndex] == rhs.percentagePerMonth![monthIndex] {
                    return lhs.name > rhs.name
                }
                return lhs.percentagePerMonth![monthIndex] > rhs.percentagePerMonth![monthIndex]
            }
            return lhs.cultivationByMonth[monthIndex].rawValue > rhs.cultivationByMonth[monthIndex].rawValue
        }
        food.imported = food.imported.sorted() { (lhs, rhs) -> Bool in
            if lhs.importByMonth[monthIndex].rawValue == rhs.importByMonth[monthIndex].rawValue {
                return lhs.name < rhs.name
            }
            return lhs.importByMonth[monthIndex].rawValue < rhs.importByMonth[monthIndex].rawValue
        }
        return food
    }
    
//    func fetchImage() {
//        let url = NSURL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients")! as URL
//        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
//        request.httpBody = try? JSONSerialization.data(withJSONObject: [
//            "query": "apple",
//            "timezone": "US/Eastern"
//        ], options: [])
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = [
//            "Content-Type": "application/json",
//            "x-app-id": "a9efa5f3",
//            "x-app-key": "855c22b96ed81051d19df5d0c1319ff8"
//        ]
//        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (result, response, error) -> Void in
//            do {
//                let data = try JSONSerialization.jsonObject(with: result!, options: [])
//                print(data)
//            } catch {
//                print(error)
//            }
//        }).resume()
//    }
    
}
