//
//  RealFeelMetric.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

// Includes information on values and units of measurement.
struct RealFeelMetric: Decodable {
    
    // MARK: - Properties
    
    let value: Double
    let unit: String
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case value = "Value"
        case unit = "Unit"
        
    }
    
}
