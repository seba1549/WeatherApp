//
//  Country.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

/// Structure representing the country.
struct Country: Decodable {
    
    // MARK: - Properties
    
    /// Name of the country.
    let name: String
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        case name = "LocalizedName"
        
    }
    
}
