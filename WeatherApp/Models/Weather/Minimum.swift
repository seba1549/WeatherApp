//
//  Minimum.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// It contains information about the lowest temperature during the period.
struct Minimum: Decodable {
    
    // MARK: - Properties
    
    let metric: Metric
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case metric = "Metric"
        
    }
    
}
