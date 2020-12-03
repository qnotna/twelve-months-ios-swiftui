//
//  CultivationFoodCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 24.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class CultivationFoodCell: FoodCell {
    var cultivationLabel: UILabel!
    var cultivationImageView = UIImageView()

    /// Only add subviews that are specific to section `.cultivated`.
    override init(_ item: Food, in month: Int) {
        super.init(item, in: month)
        setupCultivationImageView()
        setupCultivationLabel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupCultivationImageView() {
        let availability = item.cultivationByMonth[month].rawValue
        cultivationImageView.image = UIImage(named: "plant-\(availability)")
        addSubview(cultivationImageView)
        cultivationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cultivationImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cultivationImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            cultivationImageView.widthAnchor.constraint(equalToConstant: 30),
            cultivationImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    fileprivate func setupCultivationLabel() {
        let ratio = item.ratio![month]
        cultivationLabel = UILabel(text: "\(ratio)%")
        cultivationLabel.textColor = .systemGray
        addSubview(cultivationLabel)
        cultivationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cultivationLabel.trailingAnchor.constraint(equalTo: cultivationImageView.leadingAnchor, constant: -15),
            cultivationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
