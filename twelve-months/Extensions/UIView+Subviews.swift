//
//  UIView+Subviews.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 24.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Adds `views` to the end of the receiver’s list of subviews.
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
