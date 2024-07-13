//
//  AnyCitiesRepository.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Combine
import Foundation

/// Protocol describing `CitiesRepository`
protocol AnyCitiesRepository {
    
    /// Array of cities.
    var cities: [City] { get }
    
    /// Publisher reporting that a user has requested a request for a list of cities.
    var userSearchedForCities: AnyPublisher<String, Never> { get set }
    
    /// Publisher reporting that the list of cities has changed.
    var citiesListChanged: AnyPublisher<Void, Never> { get set }
    
    /// Publisher reporting that an error has occurred during data download.
    var downloadingErrorOccured: AnyPublisher<Void, Never> { get set }
    
    /// Publisher announcing that the download of the city list has started.
    var citiesAreDownloading: AnyPublisher<Void, Never> { get set }
    
    /// The method triggers a search for cities matching the specified phrase.
    func searchForCities(with phrase: String)
    
}
