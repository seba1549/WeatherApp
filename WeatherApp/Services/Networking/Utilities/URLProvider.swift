//
//  URLProvider.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// A class responsible for preparing the links needed to make queries.
struct URLProvider {
    
    // MARK: - Properties
    
    // I used force unwrapping here because this unwrapping always succeeds.
    private static var baseURL: URL { URL(string: "https://dataservice.accuweather.com/")! }
    
    // MARK: - API
    
    /// URL needed to query the server for a list of cities.
    static var locationsURL: URL {
        baseURL.appendingPathComponent("locations/v1/search")
    }
    
    /// URL needed to query the server for weather data.
    static func createWeatherDataURL(with cityKey: String) -> URL {
        baseURL.appendingPathComponent("currentconditions/v1/\(cityKey)")
    }
    
}
