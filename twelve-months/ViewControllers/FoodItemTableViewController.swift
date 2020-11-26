//
//  FoodItemTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 10.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodItemTableViewController: UITableViewController {
    
    private let dismissButton = UIButton()
    
    private var item: Food!
    private var indexPath: IndexPath!
    private var pageIndex: Int!
    private var sender: OverviewSection!
    
    init(item: Food, in month: Int, at indexPath: IndexPath, from sender: OverviewSection) {
        super.init(style: .insetGrouped)
        self.item = item
        pageIndex = month
        self.indexPath = indexPath
        self.sender = sender
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.register(MonthlyAvailabilityCell.self, forCellReuseIdentifier: "MonthlyCell")
        tableView.register(YearlyAvailabilityCell.self, forCellReuseIdentifier: "YearlyCell")
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
    
    override func numberOfSections(in tableView: UITableView) -> Int { DetailSection.allCases.count }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(DetailSection(rawValue: section)!)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch DetailSection(rawValue: section) {
        case .monthly:
            let availability: Availability?
            if sender == .cultivation {
                availability = item!.cultivationByMonth[pageIndex!]
            } else {
                availability = item!.importByMonth[pageIndex!]
            }
            #warning("Pass 'item', 'month', 'sender' instead")
            return MonthlyAvailabilityCell(type: sender!, availability: availability!, ratio: item!.ratio![pageIndex!])
        case .yearly: return YearlyAvailabilityCell(item)
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
    
    //MARK: - Actions

    /// Removes `self` from the view hierarchy
    @objc func didTapDismissSelf(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
