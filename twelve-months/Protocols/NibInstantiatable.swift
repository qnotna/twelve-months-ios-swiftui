//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

public protocol NibInstantiatable {
    static func nibName() -> String
}

extension NibInstantiatable {
    static func nibName() -> String {
        String(describing: self)
    }
}

extension NibInstantiatable where Self: UIView {
    static func fromNib() -> Self {
        if let nib = Bundle(for: self).loadNibNamed(nibName(), owner: self, options: nil) {
            // swiftlint:disable force_cast
            return nib.first as! Self
        }
        fatalError("Failed to load view from nib file.")
    }
}
