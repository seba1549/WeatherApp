//
//  AnyWeatherDataRepository.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Combine
import Foundation

/// Protocol describing `WeatherDataRepository`
protocol AnyWeatherDataRepository {
    
    /// Weather data.
    var weatherData: WeatherData? { get }
    
    /// Publisher reporting that a user has requested a request for a weather data.
    var weatherDataRequested: AnyPublisher<String, Never> { get set }
    
    /// Publisher reporting that the weather data has been downloaded.
    var weatherDataFetched: AnyPublisher<Void, Never> { get set }
    
    /// Publisher reporting that an error has occurred during data download.
    var downloadingErrorOccured: AnyPublisher<Void, Never> { get set }
    
    /// The method triggers a fetch of weather data matching the specified city key.
    ///
    /// - Parameters:
    /// - cityKey: City key for which weather data will be loaded from the resource.
    func fetchWeatherData(for cityKey: String)
    
}
