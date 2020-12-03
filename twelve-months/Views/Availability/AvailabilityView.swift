//
//  AvailabilityView.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

/// `UIStackView` with a `textLabel` and a `accessoryLabel`
class AvailabilityView: UIStackView {
    var textLabel = UILabel()
    var accessoryLabel = UILabel()

    /// Enables and disables `textLabel` and `accessoryLabel`
    var showsLabels: Bool! {
        didSet {
            textLabel.isHidden = showsLabels
            accessoryLabel.isHidden = showsLabels
        }
    }

    /// Initializes `textLabel` and `accessoryLabel` in `stackView`
    init(withLabels showsLabels: Bool) {
        super.init(frame: .zero)
        self.showsLabels = showsLabels
        spacing = 5
        axis = .vertical
        distribution = .fill
        alignment = .center
        setupTextLabel()
        setupAccessoryLabel()
    }

    required init(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupTextLabel() {
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        addArrangedSubview(textLabel)
    }

    fileprivate func setupAccessoryLabel() {
        accessoryLabel.textAlignment = .center
        accessoryLabel.textColor = .systemGray
        accessoryLabel.font = UIFont.systemFont(ofSize: 10)
        addArrangedSubview(accessoryLabel)
    }
}
