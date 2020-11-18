//
//  FoodItemTableViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 10.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodItemTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var availabilityTrafficLight: UIView!
    @IBOutlet weak var availabilityImageView: UIImageView!
    @IBOutlet weak var availabilityHeadlineLabel: UILabel!
    @IBOutlet weak var availabilityDescriptionLabel: UILabel!
    
    @IBOutlet var availabilityCultivatedCollection: [UILabel]!
    @IBOutlet var availabilityImportedCollection: [UILabel]!
    
    var item: Food?
    var indexPath: IndexPath?
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availabilityTrafficLight.layer.cornerRadius = availabilityTrafficLight.frame.width / 2
        populateTable()
    }
    
    #warning("Do not repeat population from FoodItemTableViewCell")
    func populateTable() {
        if let item = item {
            let section = indexPath!.section
            if section == AvailabilitySection.cultivation.rawValue {
                percentageLabel.isHidden = false
                availabilityImageView.isHidden = false
                let imageName = item.cultivationByMonth[pageIndex!].rawValue
                availabilityImageView.image = UIImage(named: "plant-\(imageName)")
                availabilityLabel.text = ""
                availabilityTrafficLight.backgroundColor = UIColor.clear
                availabilityHeadlineLabel.text = "\(item.cultivationByMonth[pageIndex!])"
                availabilityDescriptionLabel.text = "Buy Locally Sourced if Possible"
            } else {
                availabilityImageView.isHidden = true
                availabilityTrafficLight.backgroundColor = UIColor.matching(availability: item.importByMonth[pageIndex!])
                availabilityLabel.text = "\(item.importByMonth[pageIndex!].rawValue)"
                availabilityHeadlineLabel.text = "\(item.importByMonth[pageIndex!])"
                availabilityDescriptionLabel.text = "Shipping Creates More CO₂"
            }
            nameLabel.text = item.name.capitalized
            foodTypeLabel.text = item.type.rawValue
            availabilityLabel.textColor = .white
            percentageLabel.text = "\(item.ratio![pageIndex!])%"
            populateGraph(from: item.cultivationByMonth, to: availabilityCultivatedCollection)
            populateGraph(from: item.importByMonth, to: availabilityImportedCollection)
        }
    }
    
    #warning("Should not use 'Availability.none', use different criteria instead")
    func populateGraph(from availability: [Availability], to collection: [UILabel]) {
        for i in 0...11 {
            let label = collection[i]
            if availability[i] != .none {
                label.textColor = UIColor.systemGreen
            } else {
                label.textColor = UIColor.systemRed
            }
        }
    }
    
}
