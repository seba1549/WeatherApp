//
//  AdministrativeArea.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

/// Structure representing the administrative area.
struct AdministrativeArea: Decodable {
    
    // MARK: - Properties
    
    /// Name of the administrative area.
    let name: String
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        case name = "LocalizedName"
        
    }
    
}
