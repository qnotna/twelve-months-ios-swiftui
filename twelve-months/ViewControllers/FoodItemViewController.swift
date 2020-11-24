//
//  FoodItemViewController.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 02.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

#warning("Remove from storyboard, implement programmatically instead")
class FoodItemViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var item: Food?
    var indexPath: IndexPath?
    var pageIndex: Int?
    
    //MARK: - IBActions
    
    /// Removes self from the current view hierarchy
    /// This view controller will be closed
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Navigation
    
    /// Prepares for segue to `FoodItemTableViewController`
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        imageView.image = UIImage(named: "vegetables-fruits")
        prepareSegue(destination: segue.destination)
    }
    
    /// Sets `item`, `indexPath`, `pageIndex` to `FoodItemViewController` before a segue from this view controller is performed
    func prepareSegue(destination: UIViewController) {
        if let destination = destination as? FoodItemTableViewController {
            destination.item = item
            destination.indexPath = indexPath
            destination.pageIndex = pageIndex
        }
    }
    
}
