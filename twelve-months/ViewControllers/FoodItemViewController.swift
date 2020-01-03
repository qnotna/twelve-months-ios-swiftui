//
//  FoodItemViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodItemViewController: UIViewController {
      
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var item: Food?
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let item = self.item {
//            nameLabel.text = item.name
//        }
    }
    
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
