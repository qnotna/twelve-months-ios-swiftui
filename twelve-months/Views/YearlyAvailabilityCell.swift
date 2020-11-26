//
//  YearlyAvailabilityCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class YearlyAvailabilityCell: UITableViewCell {
    
    private var stackView: UIStackView!
    private var cultivationView: YearlyView!
    private var importView: YearlyView!
    
    var item: Food!
    
    init(_ item: Food) {
        super.init(style: .default, reuseIdentifier: "YearlyCell")
        self.item = item
        isUserInteractionEnabled = false
        setupStackView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate func setupStackView() {
        cultivationView = YearlyView(availability: item.cultivationByMonth,
                                     title: OverviewSection.cultivation.description)
        importView = YearlyView(availability: item.importByMonth,
                                title: OverviewSection.importOnly.description)
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
