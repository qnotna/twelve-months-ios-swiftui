//
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit

class TodayPageViewController: UIPageViewController {
    weak var coordinator: MainCoordinator?
    var foodTypeControl: RoundedSegmentedControl!
    var pages: [UIViewController]!

    // MARK: - Lifecycle

    init(pages: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = pages
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupToolbar()
        setupSegmentedControl()
        setupSwipeGestureRecognizers()
    }
    
    private func setupToolbar() {
        if let navigationController = navigationController as? RootController,
           let index = Month.allCases.firstIndex(of: .current) {
            // Set delegate
            navigationController.addToolbar(pages.count, index, delegate: self)
            let currentMonthController = pages[index]
            // Set initial title and controller
            navigationController.title = currentMonthController.title
            setViewControllers([currentMonthController], direction: .forward, animated: true)
        }
    }

    fileprivate func setupSegmentedControl() {
        foodTypeControl = RoundedSegmentedControl(items: FoodType.allCases.map { "\($0)" })
        foodTypeControl.addTarget(self, action: #selector(foodTypeDidChange(_:)), for: .valueChanged)
        view.addSubview(foodTypeControl)
        foodTypeControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodTypeControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodTypeControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65)
        ])
    }

    private func setupSwipeGestureRecognizers() {
        if let target = navigationController as? RootController {
            /// Previous page recognizer
            let swipePrevious = UISwipeGestureRecognizer(target: target,
                                                         action: #selector(target.didSwipeToPresentPreviousPage))
            swipePrevious.direction = .right
            view.addGestureRecognizer(swipePrevious)
            /// Next page recognizer
            let swipeNext = UISwipeGestureRecognizer(target: target,
                                                     action: #selector(target.didSwipeToPresentNextPage))
            swipeNext.direction = .left
            view.addGestureRecognizer(swipeNext)
        }
    }

    // MARK: - Actions

    /// Called by `foodTypeControl` when the value for `selectedSegmentIndex` changes
    @objc func foodTypeDidChange(_: UISegmentedControl) {
        for page in pages {
            if let viewController = page as? MonthTableViewController {
                viewController.foodType.toggle()
            }
        }
    }
}

// MARK: - `PagingToolbar` Delegate Methods

extension TodayPageViewController: PagingToolbarDelegate {
    func toolbar(_ toolbar: PagingToolbar, navigationIndexDidChange index: Int, direction: PagingDirection) {
        setViewControllers([pages[index]], direction: direction, animated: true)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func toolbar(_ toolbar: PagingToolbar, titleForNavigationIndex index: Int) -> String {
        guard let title = pages[index].title else {
            fatalError("Unexpectedly found page at index \(index) without title")
        }
        return title
    }
}
