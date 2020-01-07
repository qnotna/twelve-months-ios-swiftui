//
//  TextInputTableViewCell.swift
//  twelve-months
//
//  Created by Michal Sienkiewicz on 06.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class TextInputTableViewCell: UITableViewCell {
    let defaults = UserDefaults.standard
    
    
    @IBAction func setGender(_ sender: UISegmentedControl) {
        defaults.set(sender.selectedSegmentIndex, forKey: "gender")
    }
    
    @IBAction func setHeight(_ sender: UITextField) {
        defaults.set(Int(sender.text!), forKey: "height")
    }
    
    @IBAction func setWeight(_ sender: UITextField) {
        defaults.set(Int(sender.text!), forKey: "weight")
    }
    
    @IBAction func setAge(_ sender: UITextField) {
        defaults.set(Int(sender.text!), forKey: "age")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
