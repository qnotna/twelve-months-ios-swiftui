//
//  Coordinator.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 26.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
