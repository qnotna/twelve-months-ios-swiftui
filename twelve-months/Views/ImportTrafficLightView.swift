//
//  ImportTrafficLightView.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 24.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class ImportTrafficLightView: UIView {
    
    var scoreLabel = UILabel()
    
    var availability: Availability?
    
    init() { super.init(frame: .null) }

    init(for availability: Availability) {
        super.init(frame: .null)
        self.availability = availability
        addSubview(scoreLabel)
        setupBackground()
        setupScoreLabel()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.masksToBounds = true
        layer.cornerRadius = frame.width / 2
        scoreLabel.frame = frame
        scoreLabel.font = UIFont.systemFont(ofSize: scoreLabel.frame.height / 2,
                                            weight: .black)
    }
    
    fileprivate func setupBackground() {
        if let availability = availability {
            backgroundColor = UIColor.matching(availability: availability)
        }
    }
    
    fileprivate func setupScoreLabel() {
        if let availability = availability?.rawValue {
            scoreLabel.text = "\(availability)"
        }
        scoreLabel.textAlignment  = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
