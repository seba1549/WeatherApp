//
//  AnyNetworkingService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

protocol AnyCitiesNetworkingService {
    
    /// Method to load a list of cities from a resource.
    ///
    /// - Parameters:
    /// - phrase: Phrase for which cities will be loaded from the resource.
    func fetchCities(phrase: String, completionHandler: @escaping (Result<[City], NetworkingError>) -> ())
    
}
