//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

class RootController: UINavigationController {

    /// A toolbar replacement.
    private var customToolbar = PageControlToolbar.loadFromNib()

    /// Use the navigation controller's title for the toolbar.
    override var title: String? {
        didSet {
            guard let title = title else { return }
            customToolbar.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isToolbarHidden = false
        isNavigationBarHidden = true
    }

    /// Add a `PagingToolbar` instance as `toolbar`.
    /// - Warning:
    ///     - Since there seems to be no sensible way to add the toolbar in a xib file or from storyboard when using a `UINavigationController`, we need to add it manually.
    ///     - The correct toolbar size can only be inferred from the default `toolbar` that has to be hidden afterwards.
    /// - Parameter delegate: The delegate that should be informed about toolbar updates.
    #warning("Refactor toolbar initialization")
    func addToolbar<Delegate: PageControlToolbarDelegate>(_ index: Int, delegate: Delegate) {
        customToolbar.pageIndex = index
        view.addSubview(customToolbar)
        customToolbar.frame = toolbar.frame
        isToolbarHidden = true
        customToolbar.pageControlDelegate = delegate
    }

    /// Detected swipe to `.right`, decrements navigationIndex and calls to present new page
    @objc func didSwipeToPresentPreviousPage(_: UISwipeGestureRecognizer) {
        customToolbar.pageIndex -= 1
        didSwipeToPresentPage(in: .reverse)
    }

    /// Detected swipe to `.left`, increments navigationIndex and calls to present new page
    @objc func didSwipeToPresentNextPage(_: UISwipeGestureRecognizer) {
        customToolbar.pageIndex += 1
        didSwipeToPresentPage(in: .forward)
    }

    #warning("Selected cells stay selected when new page is presented")
    #warning("Scrollbar blinks after transition")
    /// Presents the next page animated depending on the `direction`
    private func didSwipeToPresentPage(in direction: UIPageViewController.NavigationDirection) {
        customToolbar.pageControlDelegate?.toolbar(customToolbar,
                                                  navigationIndexDidChange: customToolbar.pageIndex,
                                                  direction: direction)
    }
}
