//
//  RoundedSegmentedControl.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 27.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class RoundedSegmentedControl: UISegmentedControl {
    init(items: [String]) {
        super.init(items: items)
        selectedSegmentIndex = 0
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
