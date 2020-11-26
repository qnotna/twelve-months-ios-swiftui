//
//  RatioView.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class RatioView: AvailabilityView {

    private var contentLabel = UILabel()
    private var ratio: Int!

    init(for ratio: Int, withLabels showsLabels: Bool) {
        super.init(withLabels: showsLabels)
        self.ratio = ratio
        insertArrangedSubview(contentLabel, at: 0)
        setupViews()
    }
    
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate func setupViews() {
        print("ratio \(ratio!)")
        contentLabel.text = "\(ratio!)%"
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.systemFont(ofSize: 50, weight: .black)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
        textLabel.text = "Locally Available"
        accessoryLabel.text = "Compared to Imports"
    }

}
