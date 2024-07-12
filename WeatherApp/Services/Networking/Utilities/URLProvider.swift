//
//  URLProvider.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

final class URLProvider {
    
    // MARK: - Properties
    
    // I used force unwrapping here because this unwrapping always succeeds.
    private var baseURL: URL { URL(string: "https://dataservice.accuweather.com/")! }
    
    // MARK: - API
    
    var locationsURL: URL {
        baseURL.appendingPathComponent("locations/v1/search")
    }
    
    func createWeatherDataURL(with cityKey: String) -> URL {
        baseURL.appendingPathComponent("currentconditions/v1/\(cityKey)")
    }
    
}
