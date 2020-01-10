//
//  Image.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 10.01.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import Foundation

struct Image: Decodable {
    
    var photo: Photo
    
    struct Photo: Decodable {
        
        var thumb: String
        var highres: String
        
    }
}
