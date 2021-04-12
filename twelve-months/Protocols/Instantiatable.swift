//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

/// A type that can be instantiated either from a xib file or a storyboard.
protocol Instantiatable {}

extension Instantiatable where Self: UIViewController {
    /// Load a view from storyboard.
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self {
            return viewController
        }
        fatalError("Failed to load view controller \(fullName).")
    }
}

extension Instantiatable where Self: UIView {
    /// Load a view from a nib file.
    /// - Warning: Fails when the xib file and the class name are not equal
    static func loadFromNib() -> Self {
        let nibName = String(describing: self)
        if let nib = Bundle(for: self).loadNibNamed(nibName, owner: self, options: nil),
           let view = nib.first as? Self {
            return view
        }
        fatalError("Failed to load view from nib file \(nibName).")
    }
}
