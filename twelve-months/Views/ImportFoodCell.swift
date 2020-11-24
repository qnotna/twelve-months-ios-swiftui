//
//  ImportFoodCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 24.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class ImportFoodCell: FoodCell {
    
    var importView: ImportTrafficLightView?

    /// Only add subviews that are specific to section `.importOnly`.
    override func setup(_ item: Food) {
        super.setup(item)
        importView = ImportTrafficLightView(for: item.importByMonth[super.month!])
        addSubview(importView!)
        setupImportView()
    }
    
    fileprivate func setupImportView() {
        if let importView = importView {
            importView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                importView.centerYAnchor.constraint(equalTo: centerYAnchor),
                importView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
                importView.widthAnchor.constraint(equalToConstant: 30),
                importView.heightAnchor.constraint(equalToConstant: 30),
            ])
        }
    }
    
}
