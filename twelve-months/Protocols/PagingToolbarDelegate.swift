//
//  Copyright © 2021 Anton Quietzsch. All rights reserved.
//

import UIKit

protocol PagingToolbarDelegate: class {
    typealias PagingDirection = UIPageViewController.NavigationDirection
    
    /// Tells the data source that the navigationIndex in the toolbar has changed.
    /// - Parameters:
    ///   - toolbar: The `toolbar` instance providing the information.
    ///   - index: A number identifying the `index` in the navigationStack.
    ///   - direction: The direction in which the index might get wrapped
    func toolbar(_ toolbar: PagingToolbar,
                 navigationIndexDidChange index: Int,
                 direction: PagingDirection)

    /// Asks the data source for the title of the `toolbar` at the specified `index`.
    /// - Parameters:
    ///   - toolbar: The `toolbar` instance requesting the information
    ///   - index: A number identifying the `index` in the navigationStack.
    func toolbar(_ toolbar: PagingToolbar, titleForNavigationIndex index: Int) -> String
}
