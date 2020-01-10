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
    @IBOutlet weak var nameLabel: UILabel!

    var item: Food?
    var indexPath: IndexPath?
    var pageIndex: Int?
    
    //MARK: IBActions
    
    /// Removes self from the current view hierarchy
    /// This view controller will be closed
    /// - Parameter sender: the button that was tapped
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case StoryBoardSegueIdentifier.foodItemToFoodItemTableView.rawValue:
            if let destination = segue.destination as? FoodItemTableViewController {
                destination.item = item
                destination.indexPath = indexPath
                destination.pageIndex = pageIndex
            }
        default:
            return
        }
    }
    
}
