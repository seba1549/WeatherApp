//
//  MockCitiesNetworkingService.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Foundation

@testable import WeatherApp

/// Mock version of `CitiesNetworkingService` created for testing purposes.
final class MockCitiesNetworkingService: AnyCitiesNetworkingService {
    
    // MARK: - Properties
    
    /// List of cities that will be returned when `errorToReturn` is equal to nil.
    var citiesToReturn = [City]()
    
    /// The error that will be returned from a query for a list of cities if given a value.
    var errorToReturn: NetworkingError?
    
    // MARK: - API
    
    func fetchCities(phrase: String, completionHandler: @escaping (Result<[WeatherApp.City], WeatherApp.NetworkingError>) -> ()) {
        if let errorToReturn {
            completionHandler(.failure(errorToReturn))
            return
        }
        
        completionHandler(.success(citiesToReturn))
    }
    
}
