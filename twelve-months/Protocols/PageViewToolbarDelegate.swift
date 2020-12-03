//
//  PageViewToolbarDelegate.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 27.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

protocol PageViewToolbarDelegate: class {
    /// Tells the data source that the navigationIndex in the toolbar has changed.
    /// - Parameters:
    ///   - toolbar: The `toolbar` instance providing the information.
    ///   - index: A number identifying the `index` in the navigationStack.
    ///   - direction: The direction in which the index might get wrapped
    func toolbar(_ toolbar: PageViewToolbar,
                 navigationIndexDidChange index: Int,
                 direction: UIPageViewController.NavigationDirection)

    /// Asks the data source for the title of the `toolbar` at the specified `index`.
    /// - Parameters:
    ///   - toolbar: The `toolbar` instance requesting the information
    ///   - index: A number identifying the `index` in the navigationStack.
    func toolbar(_ toolbar: PageViewToolbar, titleForNavigationIndex index: Int) -> String
}
