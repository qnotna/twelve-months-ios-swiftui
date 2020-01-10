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
        let section = indexPath?.section
        let row = indexPath?.row
        if section == 0 {
//            item = items.cultivated[row]
            availabilityTrafficLight.isHidden = true
            percentageLabel.isHidden = false
            availabilityImageView.isHidden = false
            let imageName = (item?.cultivationByMonth[pageIndex!].rawValue)!
            availabilityImageView.image = UIImage(named: "plant-\(imageName)")
        } else {
//            item = items.imported[row]
            availabilityTrafficLight.isHidden = false
            percentageLabel.isHidden = true
            availabilityImageView.isHidden = true
        }
        nameLabel.text = item?.name.capitalized
//        percentageLabel.text = "\((item?.percentagePerMonth![pageIndex!])!)%"
//        availabilityTrafficLight.backgroundColor = colorFor(item: item!)
//        availabilityLabel.text = "\((item?.importByMonth[pageIndex!].rawValue)!)"
    }
    
    func colorFor(item: Food) -> UIColor {
        var color: UIColor?
        switch item.importByMonth[pageIndex!] {
        case .lowest:
            color = UIColor.systemGreen
        case .low:
            color = UIColor.systemOrange
        case .high:
            color = UIColor.systemRed
        case .highest:
            color = UIColor.systemPink
        default:
            color = UIColor.clear
        }
        return color!
    }
    
}
