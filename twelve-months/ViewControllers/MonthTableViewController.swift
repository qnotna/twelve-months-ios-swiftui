//
//  MonthTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 01.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class MonthTableViewController: UITableViewController, TodayPageViewControllerDelegate {
    
    var month: Month?
    var food: [Food]?
    var availableFresh = [Food]()
    var availableStored = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func pageView(didUpdateChildrenViewControllerDataFor month: Month, with food: [Food]) {
        self.title = month.rawValue
        self.month = month
        self.food = food
        for item in food {
            for available in item.availability { //TODO: this adds food from all regions
                if let fresh = available.fresh {
                    if fresh.contains(month) {
                        availableFresh.append(item)
                    }
                }
                if let stored = available.stored {
                    if stored.contains(month) {
                        availableStored.append(item)
                    }
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            let empty = self.availableFresh.count > 0
            return empty ? AvailabilityType.fresh.rawValue : AvailabilityType.none.rawValue
        default:
            let empty = self.availableStored.count > 0
            return empty ? AvailabilityType.stored.rawValue : AvailabilityType.none.rawValue
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:  return self.availableFresh.count
        default: return self.availableStored.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        switch indexPath.section {
        case 0:  cell.textLabel!.text = self.availableFresh[indexPath.row].name
        default: cell.textLabel!.text = self.availableStored[indexPath.row].name
        }
//        cell.detailTextLabel!.text = "bar"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var item: Food?
        switch indexPath.section {
        case 0:  item = self.availableFresh[indexPath.row]
        default: item = self.availableStored[indexPath.row]
        }
        performSegue(withIdentifier: "FoodItemViewControllerSegue", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodItemViewControllerSegue",
            let destination = segue.destination as? FoodItemViewController
        {
            destination.item = sender as? Food
        }
    }

}
