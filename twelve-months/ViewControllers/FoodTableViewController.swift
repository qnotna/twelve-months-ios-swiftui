//
//  FoodTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 10.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    weak var coordinator: MainCoordinator?

    private let dismissButton = UIButton()

    private var item: Food!
    private var month: Month!
    private var sender: AvailabilityType!

    init(item: Food, at month: Month, from section: Int) {
        super.init(style: .insetGrouped)
        self.item = item
        self.month = month
        sender = AvailabilityType(rawValue: section)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.register(MonthlyAvailabilityCell.self, forCellReuseIdentifier: MonthlyAvailabilityCell.identifier)
        tableView.register(YearlyAvailabilityCell.self, forCellReuseIdentifier: YearlyAvailabilityCell.identifier)
        setupNavigationBar()
    }

    fileprivate func setupNavigationBar() {
        if let title = item?.name {
            self.title = title.capitalized
        }
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapDismissSelf(_:)))
        barButtonItem.tintColor = .label
        navigationItem.rightBarButtonItem = barButtonItem
    }

    // MARK: - Actions

    /// Removes `self` from the view hierarchy
    @objc func didTapDismissSelf(_: Any) {
        coordinator?.dismiss(self)
    }
}

// MARK: - TableView Delegate Methods

extension FoodTableViewController {
    override func numberOfSections(in _: UITableView) -> Int { AvailabilityDuration.allCases.count }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        AvailabilityDuration(rawValue: section)?.description
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int { 1 }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch AvailabilityDuration(rawValue: section) {
        case .monthly: return MonthlyAvailabilityCell(item, in: month, from: sender)
        case .yearly: return YearlyAvailabilityCell(item)
        default: fatalError("Failed dequeueing FoodCell for section \(section)")
        }
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch AvailabilityDuration(rawValue: indexPath.section) {
        case .monthly: return 150
        case .yearly: return 88
        default: fatalError("Unexpectedly found illegal section \(indexPath.section)")
        }
    }
}
