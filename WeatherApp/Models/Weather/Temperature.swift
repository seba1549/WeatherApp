//
//  Temperature.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Rounded value in specified units. May be nil.
struct Temperature: Decodable {
    
    // MARK: - Properties
    
    let metric: Metric
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case metric = "Metric"
        
    }
    
}
