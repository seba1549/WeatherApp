//
//  TemperatureSummary.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// The minimum temperature observed over the past.
struct TemperatureSummary: Decodable {
    
    // MARK: - Properties
    
    let past24HourRange: TemperatureRange
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case past24HourRange = "Past24HourRange"
        
    }
    
}
