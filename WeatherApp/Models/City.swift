//
//  City.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

/// Structure representing the city.
struct City: Decodable {
    
    // MARK: - Properties
    
    /// The administrative area to which a particular city belongs.
    let area: AdministrativeArea
    
    /// Name of the city.
    let name: String
    
    /// Rank of the city.
    let rank: Int
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        case area = "AdministrativeArea"
        case name = "LocalizedName"
        case rank = "Rank"
        
    }
    
}
