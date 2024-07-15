//
//  MockCoreDataService.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 15/07/2024.
//

import CoreData
import Foundation

@testable import WeatherApp

/// Mock version of `CoreDataService` created for testing purposes.
final class MockCoreDataService: AnyCoreDataService {
    
    // MARK: - Properties
    
    var fetchSearchHistoryCalled = false
    var addCityToSearchHistoryCalled = false
    var deleteSearchHistoryCalled = false
    
    var citiesToReturn = [City]()
    lazy var cityToReturn = createMockCity()
    
    var containerPersistent: NSPersistentContainer
    
    // MARK: - Lifecycle
    
    init(containerPersistent: NSPersistentContainer) {
        self.containerPersistent = containerPersistent
    }
    
    // MARK: - API
    
    func fetchSearchHistory() -> [City] {
        fetchSearchHistoryCalled = true
        return []
    }
    
    func addCityToSearchHistory(_ city: City) {
        addCityToSearchHistoryCalled = true
    }
    
    func deleteSearchHistory() {
        deleteSearchHistoryCalled = true
    }
    
    // MARK: - Methods
    
    private func createMockCity() -> City {
        City(area: AdministrativeArea(name: "Małopolska"),
             country: Country(name: "Polska"),
             key: "Kraków",
             name: "342567",
             rank: 85)
    }
    
}
