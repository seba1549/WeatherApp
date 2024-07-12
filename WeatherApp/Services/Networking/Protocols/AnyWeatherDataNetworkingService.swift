//
//  AnyWeatherDataNetworkingService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 12/07/2024.
//

import Foundation

protocol AnyWeatherDataNetworkingService {
    
    /// Method to load a weather data from a resource.
    ///
    /// - Parameters:
    /// - cityKey: City key for which weather data will be loaded from the resource.
    func fetchWeatherData(cityKey: String, completionHandler: @escaping (Result<WeatherData, NetworkingError>) -> ())
    
}
