//
//  City.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

/// Structure representing the city.
struct City: Decodable, Equatable {
    
    // MARK: - Properties
    
    /// The administrative area to which a particular city belongs.
    let area: AdministrativeArea
    
    /// The country to which a particular city belongs.
    let country: Country
    
    /// Location key, needed to download weather data for the selected location.
    let key: String
    
    /// Name of the city.
    let name: String
    
    /// Rank of the city.
    let rank: Int
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        case area = "AdministrativeArea"
        case country = "Country"
        case key = "Key"
        case name = "LocalizedName"
        case rank = "Rank"
        
    }
    
}
