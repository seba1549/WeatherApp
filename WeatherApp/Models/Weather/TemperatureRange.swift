//
//  TemperatureRange.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// It contains information about the highest and lowest temperatures during the period.
struct TemperatureRange: Decodable {
    
    // MARK: - Properties
    
    let minimum: Minimum
    let maximum: Maximum
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case minimum = "Minimum"
        case maximum = "Maximum"
        
    }
    
}
