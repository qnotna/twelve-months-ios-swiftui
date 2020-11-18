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
    
    func populate(from items: Goods, at indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        var item: Food?
        if section == AvailabilitySection.cultivation.rawValue {
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
        percentageLabel.text = "\((item?.ratio![pageIndex!])!)%"
        availabilityTrafficLight.backgroundColor = UIColor.matching(availability: item!.importByMonth[pageIndex!])
        availabilityLabel.text = "\((item?.importByMonth[pageIndex!].rawValue)!)"
        availabilityLabel.textColor = UIColor.white
    }
    
}
