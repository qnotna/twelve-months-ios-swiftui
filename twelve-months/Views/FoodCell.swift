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

    var thumbImageView = UIImageView()
    var nameLabel = UILabel()
    
    internal var item: Food!
    internal var month: Int!
    
    init(_ item: Food, in month: Int) {
        super.init(style: .default, reuseIdentifier: "FoodCell")
        self.month = month
        self.item = item
        self.item = item
        self.accessoryType = .disclosureIndicator
        addSubviews(thumbImageView, nameLabel)
        setupThumbImageView()
        setupNameLabel()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate func setupThumbImageView() {
        thumbImageView.image = UIImage(named: item.name)
        thumbImageView.contentMode = .scaleAspectFit
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            thumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 35),
            thumbImageView.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    fileprivate func setupNameLabel() {
        if let name = item?.name.capitalized {
            nameLabel.text = name
        }
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
