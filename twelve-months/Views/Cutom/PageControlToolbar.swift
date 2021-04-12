//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

class PageControlToolbar: UIToolbar, Instantiatable {

    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Properties

    weak var pageControlDelegate: PageControlToolbarDelegate?

    /// Current working index in navigationStack
    @RollingIndex(in: 0..<Month.allCases.count, startingAt: Month.index(of: .current)) var pageIndex: Int {
        didSet {
            title = pageControlDelegate?.toolbar(self, titleForNavigationIndex: pageIndex)
        }
    }
    /// Title for `titleLabel`
    var title: String? {
        willSet {
            if newValue != nil {
                titleLabel.text = newValue
            }
        }
    }

    // MARK: - Actions

    /// Delegate title change and informs about decremented `navigationIndex`
    @IBAction private func didTapPreviousButton(_: Any) {
        pageIndex -= 1
        pageControlDelegate?.toolbar(self, navigationIndexDidChange: pageIndex, direction: .reverse)
    }

    /// Delegate title change and informs about incremented `navigationIndex`
    @IBAction private func didTapNextButton(_: Any) {
        pageIndex += 1
        pageControlDelegate?.toolbar(self, navigationIndexDidChange: pageIndex, direction: .forward)
    }
}
