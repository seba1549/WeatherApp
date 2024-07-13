//
//  MockWeatherDataNetworkingService.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Foundation

@testable import WeatherApp

/// Mock version of `WeatherDataNetworkingService` created for testing purposes.
final class MockWeatherDataNetworkingService: AnyWeatherDataNetworkingService {
    
    // MARK: - Properties
    
    /// List of cities that will be returned when `errorToReturn` is equal to nil.
    var weatherDataToReturn: WeatherData?
    
    /// The error that will be returned from a query for a list of cities if given a value.
    var errorToReturn: NetworkingError?
    
    // MARK: - API
    
    func fetchWeatherData(cityKey: String, completionHandler: @escaping (Result<WeatherData, NetworkingError>) -> ()) {
        if let errorToReturn {
            completionHandler(.failure(errorToReturn))
            return
        }
        
        if let weatherDataToReturn {
            completionHandler(.success(weatherDataToReturn))
            return
        }
    }
    
}
