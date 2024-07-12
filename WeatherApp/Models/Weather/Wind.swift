//
//  Wind.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Describes the wind parameters occurring at the selected location.
struct Wind: Decodable {
    
    // MARK: - Properties
    
    let speed: Speed
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "Speed"
        
    }
    
}
