//
//  CoreDataServiceTests.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 14/07/2024.
//

import CoreData
import Foundation
import XCTest

@testable import WeatherApp

final class CoreDataServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    private var coreDataService: AnyCoreDataService!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        let coreDataStack = TestCoreDataStack()
        coreDataService = CoreDataService(containerPersistent: coreDataStack.persistentContainer)
    }
    
    override func tearDown() {
        coreDataService = nil
    }
    
    // MARK: - Tests
    
    func test_fetchSearchHistory() {
        let containerPersistent = coreDataService.containerPersistent
        let context = containerPersistent.viewContext
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            true
        }
        
        let city = createMockCity()
        coreDataService.addCityToSearchHistory(city)
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }
        
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        guard let result = try? context.fetch(fetchRequest) else {
            XCTFail("CoreData data could not be loaded.")
            return
        }
        
        XCTAssertEqual(result.count, 1)
    }
    
    func test_addCityToSearchHistory() {
        let containerPersistent = coreDataService.containerPersistent
        let context = containerPersistent.viewContext
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            true
        }
        
        let city = createMockCity()
        coreDataService.addCityToSearchHistory(city)
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }
        
        let fetchedCities = coreDataService.fetchSearchHistory()
        XCTAssertEqual(fetchedCities.count, 1)
    }
    
    func test_deleteSearchHistory() {
        let containerPersistent = coreDataService.containerPersistent
        let context = containerPersistent.viewContext
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            true
        }
        
        let city = createMockCity()
        coreDataService.addCityToSearchHistory(city)
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }
        
        coreDataService.deleteSearchHistory()
        
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        guard let result = try? context.fetch(fetchRequest) else {
            XCTFail("CoreData data could not be loaded.")
            return
        }
        
        XCTAssertEqual(result.count, 0)
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
