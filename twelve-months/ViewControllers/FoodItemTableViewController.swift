//
//  FoodItemTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 10.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodItemTableViewController: UITableViewController {
    
    weak var coordiantor: MainCoordinator?
    
    private let dismissButton = UIButton()
    
    private var item: Food!
    private var pageIndex: Int!
    private var sender: OverviewSection!
    
    init(item: Food, at pageIndex: Int, from section: Int) {
        super.init(style: .insetGrouped)
        self.item = item
        self.pageIndex = pageIndex
        self.sender = OverviewSection(rawValue: section)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
    
    //MARK: - Actions

    /// Removes `self` from the view hierarchy
    @objc func didTapDismissSelf(_ sender: Any) {
        coordiantor?.dismissViewController(self)
    }
    
}

// MARK: - TableView Delegate Methods

extension FoodItemTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { DetailSection.allCases.count }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(DetailSection(rawValue: section)!)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch DetailSection(rawValue: section) {
        case .monthly: return MonthlyAvailabilityCell(item, in: pageIndex, from: sender)
        case .yearly:  return YearlyAvailabilityCell(item)
        default: fatalError("Failed dequeueing FoodCell for section \(section)")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch DetailSection(rawValue: indexPath.section) {
        case .monthly: return 150
        case .yearly:  return 88
        default: fatalError("Unexpectedly found illegal section \(indexPath.section)")
        }
    }
    
}
