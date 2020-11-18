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
                availabilityHeadlineLabel.text = "\(descriptionFor(availability: item.cultivationByMonth)) Cultivation"
                availabilityDescriptionLabel.text = "Buy Locally Sourced if Possible"
            } else {
                availabilityImageView.isHidden = true
                availabilityTrafficLight.backgroundColor = colorFor(item: item)
                availabilityLabel.text = "\(item.importByMonth[pageIndex!].rawValue)"
                availabilityHeadlineLabel.text = "\(descriptionFor(availability: item.importByMonth)) Import"
                availabilityDescriptionLabel.text = "Shipping Creates More CO₂"
            }
            nameLabel.text = item.name.capitalized
            foodTypeLabel.text = item.type.rawValue
            availabilityLabel.textColor = .white
            percentageLabel.text = "\(item.percentagePerMonth![pageIndex!])%"
            populateGraph(from: item.cultivationByMonth, to: availabilityCultivatedCollection)
            populateGraph(from: item.importByMonth, to: availabilityImportedCollection)
        }
    }
    
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
     
    func colorFor(item: Food) -> UIColor {
        var color: UIColor?
        switch item.importByMonth[pageIndex!] {
        case .lowest:  color = .systemOrange
        case .low:     color = .systemRed
        case .high:    color = .systemPink
        case .highest: color = .systemPurple
        default:       color = .clear
        }
        return color!
    }
    
    func descriptionFor(availability: [Availability]) -> String {
        var description: String?
        switch availability[pageIndex!] {
        case .lowest:  description = "Small"
        case .low:     description = "Medium"
        case .high:    description = "Large"
        case .highest: description = "Heavy"
        default:       description = "This should never happen"
        }
        return description!
    }
    
}
