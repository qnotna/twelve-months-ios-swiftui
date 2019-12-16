//
//  BundleDecodable.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 16.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation

extension Bundle {
    
    func decode(file: String) -> [Plant] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode([Plant].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}
