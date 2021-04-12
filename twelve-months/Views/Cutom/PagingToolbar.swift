//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

class PagingToolbar: UIToolbar, NibInstantiatable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Properties
    
    #warning("Rename to navigator")
    weak var navigationDelegate: PagingToolbarDelegate?

    /// Total size of navigationStack
    var pageCount: Int = 0
    /// Current working index in navigationStack
    var pageIndex: Int = 0
    /// Title for `titleLabel`
    var title: String? {
        willSet {
            if newValue != nil {
                titleLabel.text = newValue
            }
        }
    }
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(withSize count: Int, startingAt index: Int) {
//        super.init(frame: .zero)
        assert(count > 0, "navigationSize must be larger than 0. Found '\(count)'")
        self.pageCount = count
        assert((0 ..< count).contains(index),
               "navigationIndex must be within 0..<\(count). Found '\(count)'")
        self.pageIndex = index
    }
    
//    @available(*, unavailable)
//    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Actions

    /// Delegate title change and informs about decremented `navigationIndex`
    @IBAction private func didTapPreviousButton(_: Any) {
        decrementIndex()
        reloadTitle()
        navigationDelegate?.toolbar(self, navigationIndexDidChange: pageIndex, direction: .reverse)
    }

    /// Delegate title change and informs about incremented `navigationIndex`
    @IBAction private func didTapNextButton(_: Any) {
        incrementIndex()
        reloadTitle()
        navigationDelegate?.toolbar(self, navigationIndexDidChange: pageIndex, direction: .forward)
    }
    
    // MARK: - Modifying index
    #warning("This should be done by a protocol")

    /// Decrements `navigationIndex` by 1, wraps around to `0` if `navigationSize` is reached
    func decrementIndex() {
        var previousIndex = pageIndex - 1
        if previousIndex < 0 { previousIndex = pageCount - 1 }
        guard pageCount > previousIndex else { return }
        pageIndex = previousIndex
    }

    /// Increments `navigationIndex` by 1, wraps around to `navigationSize` if `0` is reached
    func incrementIndex() {
        var nextIndex = pageIndex + 1
        if pageCount == nextIndex { nextIndex = 0 }
        guard pageCount > nextIndex else { return }
        pageIndex = nextIndex
    }

    // MARK: - Reload Data

    func reloadTitle() {
        title = navigationDelegate?.toolbar(self, titleForNavigationIndex: pageIndex)
    }
}
