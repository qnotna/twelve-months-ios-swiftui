//
//  FoodCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class FoodCell: UITableViewCell {
    static let identifier = "FoodCell"

    var thumbImageView = UIImageView()
    var nameLabel: UILabel!

    var item: Food!
    var month: Month!

    init(_ item: Food, in month: Month) {
        super.init(style: .default, reuseIdentifier: FoodCell.identifier)
        self.month = month
        self.item = item
        self.item = item
        accessoryType = .disclosureIndicator
        setupThumbImageView()
        setupNameLabel()
    }

    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupThumbImageView() {
        thumbImageView.image = UIImage(named: item.name)
        thumbImageView.contentMode = .scaleAspectFit
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumbImageView)
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            thumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 35),
            thumbImageView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    fileprivate func setupNameLabel() {
        if let name = item?.name.capitalized {
            nameLabel = UILabel(text: name)
            addSubview(nameLabel)
        }
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
