//
//  TodayPageViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit

class TodayPageViewController: UIPageViewController {
    
    weak var coordinator: MainCoordinator?
    
    var toolbar: PageViewToolbar!
    var foodTypeControl: RoundedSegmentedControl!
    var pages: [UIViewController]!
    
    // MARK: - Lifecycle
    
    init(pages: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = pages
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolbar()
        setupSegmentedControl()
        setupSwipeGestureRecognizers()
    }
    
    fileprivate func setupToolbar() {
        guard let index = Month.allCases.firstIndex(of: Month.current) else { return }
        toolbar = PageViewToolbar(withSize: pages.count, startingAt: index)
        toolbar.title = pages[index].title!
        toolbar.navigationDelegate = self
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        setViewControllers([pages[index]], direction: .forward, animated: true)
    }
    
    fileprivate func setupSegmentedControl() {
        foodTypeControl = RoundedSegmentedControl(items: FoodType.allCases.map { "\($0)" })
        foodTypeControl.addTarget(self, action: #selector(foodTypeDidChange(_:)), for: .valueChanged)
        view.addSubview(foodTypeControl)
        foodTypeControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodTypeControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodTypeControl.bottomAnchor.constraint(equalTo: toolbar.topAnchor, constant: -15)
        ])
    }
    
    fileprivate func setupSwipeGestureRecognizers() {
        /// Previous page recognizer
        let swipePrevious = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeToPresentPreviousPage(_:)))
        swipePrevious.direction = .right
        view.addGestureRecognizer(swipePrevious)
        /// Next page recognizer
        let swipeNext = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeToPresentNextPage(_:)))
        swipeNext.direction = .left
        view.addGestureRecognizer(swipeNext)
    }

    // MARK: - Actions
    
    /// Called by `foodTypeControl` when the value for `selectedSegmentIndex` changes
    @objc func foodTypeDidChange(_ segmentedControl: UISegmentedControl) {
        for page in pages {
            if let viewController = page as? MonthTableViewController {
                viewController.foodType.toggle()
            }
        }
    }
    
    /// Detected swipe to `.right`, decrements navigationIndex and calls to present new page
    @objc func didSwipeToPresentPreviousPage(_ gestureRecognizer: UISwipeGestureRecognizer) {
        toolbar.decrementIndex()
        didSwipeToPresentPage(in: .reverse)
    }
    
    /// Detected swipe to `.left`, increments navigationIndex and calls to present new page
    @objc func didSwipeToPresentNextPage(_ gestureRecognizer: UISwipeGestureRecognizer) {
        toolbar.incrementIndex()
        didSwipeToPresentPage(in: .forward)
    }
    
    #warning("Selected cells stay selected when new page is presented")
    #warning("Scrollbar blinks after transition")
    /// Presents the next page animated depending on the `direction`
    private func didSwipeToPresentPage(in direction: UIPageViewController.NavigationDirection) {
        let viewController = pages[toolbar.navigationIndex!]
        setViewControllers([viewController], direction: direction, animated: true)
        toolbar.reloadTitle()
    }
    
}

// MARK: - PageViewToolbar Delegate Methods

extension TodayPageViewController: PageViewToolbarDelegate {
    /// Set the next page to be presented
    func toolbar(_ toolbar: PageViewToolbar, navigationIndexDidChange index: Int, direction: UIPageViewController.NavigationDirection) {
        setViewControllers([pages[index]], direction: direction, animated: true)
    }
    /// Title of the current page
    func toolbar(_ toolbar: PageViewToolbar, titleForNavigationIndex index: Int) -> String {
        pages[index].title!
    }
}
