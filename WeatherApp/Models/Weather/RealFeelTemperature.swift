//
//  RealFeelTemperature.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Patented AccuWeather RealFeel Temperature.
struct RealFeelTemperature: Decodable, Equatable {
    
    // MARK: - Properties
    
    let metric: RealFeelMetric
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case metric = "Metric"
        
    }
    
}
