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
    override init(_ item: Food, in month: Int) {
        super.init(item, in: month)
        importView = ImportTrafficLightView(for: item.importByMonth[super.month!])
        addSubview(importView!)
        setupImportView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
