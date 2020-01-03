//
//  FoodItemViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class FoodItemViewController: UIViewController {
      
    @IBOutlet weak var imageView: UIImageView!
    
    var item: Food?
    
    //MARK: IBActions
    
    /// Removes self from the current view hierarchy
    /// This view controller will be closed
    /// - Parameter sender: the button that was tapped
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
