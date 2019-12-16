//
//  Region.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation
import CoreLocation

enum Region: String, Decodable, CaseIterable {
    
    case northernEurope = "Northern Europe"
    case easternEurope = "Eastern Europe"
    case southernEurope = "Southern Europe"
    case westernEurope = "Western Europe"

    case northernAfrica = "Northern Africa"
    case easternAfrica = "Eastern Africa"
    case southernAfrica = "Southern Africa"
    case westernAfrica = "Western Africa"
    case middleAfrica = "Middle Africa"

    case northernAmerica = "Northern America"
    case centralAmerica = "Central America"
    case southAmerica = "South America"
    case carribean = "Caribbean"

    case easternAsia = "Eastern Asia"
    case southernAsia = "Southern Asia"
    case westernAsia = "Western Asia"
    case centralAsia = "Central Asia"
    case southEasternAsia = "South-eastern Asia"

    case micronesia = "Micronesia"
    case polynesia = "Polynesia"
    case malenasia = "Melanesia"
    case australiaAndNewZealand = "Australia & New Zealand"
    
    case antarctica = "Antarctica"
    case other = "Your country is not yet supported or not recognized by the United Nations"
    
}
