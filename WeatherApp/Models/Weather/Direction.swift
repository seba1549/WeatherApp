//
//  Direction.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Describes the wind direction occurring at the selected location.
struct Direction: Decodable {
    
    // MARK: - Properties
    
    let localized: String
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case localized = "Localized"
        
    }
    
}
