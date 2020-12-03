//
//  RegionType.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 15.12.19.
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import Foundation
import CoreLocation

enum RegionType: String, Decodable, CaseIterable {
    
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
    
    #warning("'.other' should not be nessecary")
    case other = "Your country is not yet supported"
    
    /// This can be called at all times to receive the current region as Region case
    /// Will default to unsupported region
    static var current: RegionType {
        let regions = Bundle.main.decode([Region].self, from: Region.url)
        if let regionCode = NSLocale.current.regionCode {
            for region in regions {
                if region.countries.contains(regionCode) {
                    return region.name
                }
            }
        }
        return RegionType.other
    }
    
}
