//
//  YearlyView.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 26.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class YearlyView: UIView {
    
    private var descriptionLabel: UILabel!
    private var stackView: UIStackView!
    
    private var availability = [Availability]()
    private var title: String!
    
    init(availability: [Availability], title: String) {
        super.init(frame: .zero)
        self.availability = availability
        self.title = title
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate func setupViews() {
        descriptionLabel = UILabel(text: title)
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        /// Add a label with the first letters of each month case as text to a list of labels
        let months = Month.allCases.compactMap {
            UILabel(text: $0.rawValue.substring(in: 0..<1))
        }
        setupStackView(arrangedSubviews: months)
        project(availability, to: stackView.arrangedSubviews)
    }

    fileprivate func setupStackView(arrangedSubviews subviews: [UIView]) {
        stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    #warning("Replace with actual graph someday, use 'UIColor.matching(availability:)'")
    func project(_ availability: [Availability], to collection: [UIView]) {
        for i in 0...11 {
            let label = collection[i] as! UILabel
            switch availability[i] {
            case .lowest, .low, .high, .highest:
                label.textColor = UIColor.systemGreen
            default:
                label.textColor = UIColor.systemRed
            }
        }
    }
}
