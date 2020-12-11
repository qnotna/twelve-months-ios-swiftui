//
//  ImportFoodCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 24.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class ImportFoodCell: FoodCell {
    var importView: ImportTrafficLightView!

    /// Only add subviews that are specific to section `.importOnly`.
    override init(_ item: Food, in month: Month) {
        super.init(item, in: month)
        setupImportView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupImportView() {
        let index = Month.index(of: super.month)
        importView = ImportTrafficLightView(for: item.importByMonth[index])
        addSubview(importView)
        importView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            importView.centerYAnchor.constraint(equalTo: centerYAnchor),
            importView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            importView.widthAnchor.constraint(equalToConstant: 30),
            importView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
