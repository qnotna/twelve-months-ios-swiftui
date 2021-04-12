//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

protocol Storyboarded {}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        // swiftlint:disable force_cast
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
