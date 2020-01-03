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
    
    //MARK: UIPageViewControllerDelegate methods
    
    /// Tells the UIPageViewController which page should be displayed before the current page
    /// Calculates the index for the next page if a list overflow happens at the beginning of the pages list
    /// The index will wrap around if it is smaller than 0
    /// - Parameters:
    ///   - pageViewController: The page view controller
    ///   - viewController: The view controller that the user navigated away from.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
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
    
}

//MARK: Create pages

extension TodayPageViewController: UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        let food = Bundle.main.decode([Food].self, from: "foods.json")
        todayView(didDecodeFood: food)
    }
    
    /// Creates the page view controllers for the UIPageViewController
    /// Sets a MonthViewController as the current page
    /// - Parameter food: list of decoded food
    func todayView(didDecodeFood food: [Food]) {
        pages = createPageViewControllers(from: months, with: food)
        if let currentViewController = pages?.first { //TODO: always displays january as first page
            setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    /// Instantiates each MonthViewController to be added as Page to the UIPageViewController
    /// Creates the view controllers from the storyboard without segue
    /// Informs each MonthViewController as TodayPageViewControllerDelegate that data has been updated
    /// - Parameters:
    ///   - months: all months
    ///   - food: all food
    /// - Returns: a list of all MonthViewControllers
    func createPageViewControllers(from months: [Month], with food: [Food]) -> [UIViewController] {
        var viewControllers = [UIViewController]()
        for month in months {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MonthNavigationViewController")
            viewControllers.append(viewController)
            if let monthViewController = viewController.children.first { //TODO: the current page is always january
                todayDelegate = monthViewController as? TodayPageViewControllerDelegate
                todayDelegate?.pageView(didUpdateChildrenViewControllerDataFor: month, with: food)
            }
            
        }
        return viewControllers
    }
    
}
