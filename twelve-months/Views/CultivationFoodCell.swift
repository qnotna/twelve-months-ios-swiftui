//
//  CultivationFoodCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 24.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class CultivationFoodCell: FoodCell {
    
    var cultivationLabel = UILabel()
    var cultivationImageView = UIImageView()
    
    /// Only add subviews that are specific to section `.cultivated`.
    override init(_ item: Food, in month: Int) {
        super.init(item, in: month)
        addSubviews(cultivationLabel, cultivationImageView)
        setupCultivationLabel()
        setupCultivationImageView(for: item.cultivationByMonth[month])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate func setupCultivationLabel() {
        if let item = item, let month = month {
            cultivationLabel.text = "\(item.ratio![month])%"
        }
        cultivationLabel.textColor = .systemGray
        cultivationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cultivationLabel.trailingAnchor.constraint(equalTo: cultivationImageView.leadingAnchor, constant: -15),
            cultivationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    fileprivate func setupCultivationImageView(for availability: Availability) {
        cultivationImageView.image = UIImage(named: "plant-\(availability.rawValue)")
        cultivationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cultivationImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cultivationImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            cultivationImageView.widthAnchor.constraint(equalToConstant: 30),
            cultivationImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}
