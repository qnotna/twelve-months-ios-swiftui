//
//  FoodItemTableViewswift
//  twelve-months
//
//  Created by Anton Quietzsch on 09.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

#warning("Refactor into two cells: '.vegetable' and '.fruit'")
class FoodItemTableViewCell: UITableViewCell {

    var thumbImageView = UIImageView()
    var nameLabel = UILabel()
    var cultivationLabel = UILabel()
    var cultivationImageView = UIImageView()
    var importView: ImportTrafficLightView?
    
    private var item: Food?
    
    #warning("Do not pass month to cell")
    var month: Int?
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setup(cultivated item: Food) {
        self.accessoryType = .disclosureIndicator
        self.item = item
        addSubviews(cultivationLabel, cultivationImageView)
        setupCultivationLabel()
        setupCultivationImageView(for: item.cultivationByMonth[month!])
        setup()
    }
    
    func setup(imported item: Food) {
        self.item = item
        importView = ImportTrafficLightView(for: item.importByMonth[month!])
        addSubview(importView!)
        setupImportView()
        setup()
    }
    
    func setup() {
        addSubviews(thumbImageView, nameLabel)
        setupThumbImageView()
        setupNameLabel()
    }
    
    fileprivate func setupThumbImageView() {
        if let item = item {
            thumbImageView.image = UIImage(named: item.name)
        }
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
    
    fileprivate func setupImportView() {
        if let importView = importView {
            importView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                importView.centerYAnchor.constraint(equalTo: centerYAnchor),
                importView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                importView.widthAnchor.constraint(equalToConstant: 30),
                importView.heightAnchor.constraint(equalToConstant: 30),
            ])
        }
    }
    
}
