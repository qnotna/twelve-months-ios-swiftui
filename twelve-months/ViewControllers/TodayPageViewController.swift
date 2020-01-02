//
//  TodayPageViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit
import CoreLocation

class TodayPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var todayDelegate: TodayPageViewControllerDelegate?
    var pages: [UIViewController]?
    let months: [Month] = [.january, .february, .march, .april, .may, .june, .july, .august, .september, .october, .november, .december]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        let food = Bundle.main.decode([Food].self, from: "foods.json")
        pages = createPageViewControllers(from: months, with: food)
        if let currentViewController = pages?.first {
            setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    func createPageViewControllers(from months: [Month], with food: [Food]) -> [UIViewController] {
        var viewControllers = [UIViewController]()
        for month in months {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MonthNavigationViewController")
            viewControllers.append(viewController)
            if let monthViewController = viewController.children.first { //TODO: the current page is always .january
                todayDelegate = monthViewController as? TodayPageViewControllerDelegate
                todayDelegate?.pageView(didUpdateChildrenViewControllerDataFor: month, with: food)
            }
            
        }
        return viewControllers
    }
    
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages!.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return months.firstIndex(of: Month.current)!
    }
    
}
