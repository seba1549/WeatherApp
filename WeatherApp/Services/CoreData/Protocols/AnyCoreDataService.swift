//
//  AnyCoreDataService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 14/07/2024.
//

import CoreData
import Foundation

/// A protocol describing the class that manages the coredata.
protocol AnyCoreDataService {
    
    var containerPersistent: NSPersistentContainer { get }
    
    /// Allows you to load your search history.
    func fetchSearchHistory() -> [City]
    
    /// Allows you to add city to search history.
    func addCityToSearchHistory(_ city: City)
    
    /// Allows you to delete all search history.
    func deleteSearchHistory()
    
}
