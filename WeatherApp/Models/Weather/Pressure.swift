//
//  Pressure.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Atmospheric pressure.
struct Pressure: Decodable {
    
    // MARK: - Properties
    
    let metric: Metric
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case metric = "Metric"
        
    }
    
}
