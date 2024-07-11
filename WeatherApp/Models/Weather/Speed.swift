//
//  Speed.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Describes the wind speed occurring at the selected location.
struct Speed: Decodable {
    
    // MARK: - Properties
    
    let metric: Metric
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case metric = "Metric"
        
    }
    
}
