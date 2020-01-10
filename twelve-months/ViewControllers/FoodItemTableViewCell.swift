//
//  FoodItemTableViewswift
//  twelve-months
//
//  Created by Anton Quietzsch on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var availabilityTrafficLight: UIView!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var availabilityImageView: UIImageView!
    
    var indexPath: IndexPath?
    var pageIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        availabilityTrafficLight.layer.cornerRadius = availabilityTrafficLight.frame.width / 2
    }
    
    func populate(from items: (cultivated: [Food], imported: [Food]), at indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var item: Food?
        if section == 0 {
            item = items.cultivated[row]
            availabilityTrafficLight.isHidden = true
            percentageLabel.isHidden = false
            availabilityImageView.isHidden = false
            let imageName = (item?.cultivationByMonth[pageIndex!].rawValue)!
            availabilityImageView.image = UIImage(named: "plant-\(imageName)")
        } else {
            item = items.imported[row]
            availabilityTrafficLight.isHidden = false
            percentageLabel.isHidden = true
            availabilityImageView.isHidden = true
        }
        imageView!.image = UIImage(named: item!.name)
        nameLabel.text = item?.name.capitalized
        percentageLabel.text = "\((item?.percentagePerMonth![pageIndex!])!)%"
        availabilityTrafficLight.backgroundColor = colorFor(item: item!)
        availabilityLabel.text = "\((item?.importByMonth[pageIndex!].rawValue)!)"
        availabilityLabel.textColor = UIColor.white
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
    
}
