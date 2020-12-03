//
//  ImportView.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class ImportView: AvailabilityView {
    private var contentView: ImportTrafficLightView?

    private var availability: Availability!

    init(for availability: Availability, withLabels showsLabels: Bool) {
        super.init(withLabels: showsLabels)
        self.availability = availability
        contentView = ImportTrafficLightView(for: availability)
        insertArrangedSubview(contentView!, at: 0)
        setupViews()
    }

    required init(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupViews() {
        contentView?.availability = availability
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView!.widthAnchor.constraint(equalToConstant: 80),
            contentView!.heightAnchor.constraint(equalToConstant: 80)
        ])
        textLabel.text = "\(availability!) Import"
        accessoryLabel.text = "Shipping Creates More CO₂"
    }
}
