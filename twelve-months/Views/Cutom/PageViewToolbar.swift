//
//  PageViewToolbar.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 27.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class PageViewToolbar: UIToolbar {
    var previousButton: UIBarButtonItem!
    var titleLabel: UILabel!
    var nextButton: UIBarButtonItem!

    // MARK: - Variables

    weak var navigationDelegate: PageViewToolbarDelegate?

    /// Total size of navigationStack
    var pageCount: Int!
    /// Current working index in navigationStack
    var pageIndex: Int!
    /// Title for `titleLabel`
    var title: String? {
        willSet {
            if newValue != nil {
                titleLabel.text = newValue
            }
        }
    }

    // MARK: - Lifecycle

    init(withSize count: Int, startingAt index: Int) {
        super.init(frame: .zero)
        assert(count > 0, "navigationSize must be larger than 0. Found '\(count)'")
        self.pageCount = count
        assert((0 ..< count).contains(index),
               "navigationIndex must be within 0..<\(count). Found '\(count)'")
        self.pageIndex = index
        setupBarButtonItems()
        setupTitleLabel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupBarButtonItems() {
        previousButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left.circle.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapPreviousButton(_:)))
        nextButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right.circle.fill"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(didTapNextButton(_:)))
    }

    fileprivate func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: titleLabel.font.pointSize, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        items = [previousButton,
                 flexibleSpace,
                 UIBarButtonItem(customView: titleLabel),
                 flexibleSpace,
                 nextButton]
    }

    // MARK: - Actions

    /// Delegate title change and informs about decremented `navigationIndex`
    @objc private func didTapPreviousButton(_: UIBarButtonItem) {
        decrementIndex()
        reloadTitle()
        navigationDelegate?.toolbar(self, navigationIndexDidChange: pageIndex, direction: .reverse)
    }

    /// Delegate title change and informs about incremented `navigationIndex`
    @objc private func didTapNextButton(_: UIBarButtonItem) {
        incrementIndex()
        reloadTitle()
        navigationDelegate?.toolbar(self, navigationIndexDidChange: pageIndex, direction: .forward)
    }

    // MARK: - Modifying index

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
