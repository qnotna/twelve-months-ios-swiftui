//
//  YearlyAvailabilityCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class YearlyAvailabilityCell: UITableViewCell {
    static let identifier = "YearlyCell"

    private var stackView: UIStackView!
    private var cultivationView: YearlyView!
    private var importView: YearlyView!

    var item: Food!

    init(_ item: Food) {
        super.init(style: .default, reuseIdentifier: YearlyAvailabilityCell.identifier)
        self.item = item
        isUserInteractionEnabled = false
        setupStackView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupStackView() {
        cultivationView = YearlyView(availability: item.cultivationByMonth,
                                     title: AvailabilityType.cultivation.description)
        importView = YearlyView(availability: item.importByMonth,
                                title: AvailabilityType.importOnly.description)
        stackView = UIStackView(arrangedSubviews: [cultivationView, importView])
        stackView.axis = .vertical
        stackView.frame = frame
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
