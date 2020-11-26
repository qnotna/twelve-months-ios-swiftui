//
//  TodayPageViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit

#warning("Page Control should wrap")
class TodayPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    weak var coordinator: MainCoordinator?
    
    var pages: [UIViewController]!
    
    init(pages: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = pages
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    /// SegmentedControl as `navigationItem`
    lazy var foodTypeControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Vegetables", "Fruits"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(foodTypeDidChange(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    //MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        guard let index = Month.allCases.firstIndex(of: Month.current) else { return }
        setViewControllers([pages[index]], direction: .forward, animated: true)
        setupViews()
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
    
    // MARK: - Actions
    
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
