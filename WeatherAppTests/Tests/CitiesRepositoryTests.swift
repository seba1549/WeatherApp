//
//  CitiesRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Combine
import Foundation
import XCTest

@testable import WeatherApp

/// Class containing tests for `CitiesRepository`.
final class CitiesRepositoryTests: XCTestCase {

    // MARK: - Properties
    
    private var sut: AnyCitiesRepository!
    private var networkingService: MockCitiesNetworkingService!
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        let networkingService = MockCitiesNetworkingService()
        sut = CitiesRepository(networkingService: networkingService)
        self.networkingService = networkingService
        cancellables = [AnyCancellable]()
    }
    
    override func tearDown() {
        networkingService = nil
        sut = nil
        cancellables = [AnyCancellable]()
    }
    
    // MARK: - Tests
    
    func test_searchForCities() {
        let expectation = XCTestExpectation(description: "userSearchedForCities")
        let phrase = "Test"
        
        sut.userSearchedForCities
            .sink { text in
                XCTAssertEqual(text, phrase)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.searchForCities(with: phrase)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_searchForCities_downloadingWithPhrase() {
        let expectation = XCTestExpectation(description: "citiesListChanged")
        let phrase = "Paryż"
        
        networkingService.citiesToReturn = createMockCities()
        sut.citiesListChanged
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.searchForCities(with: phrase)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.cities, createMockCities())
    }
    
    func test_searchForCities_downloadingWithEmptyPhrase() {
        let expectation = XCTestExpectation(description: "citiesListChanged")
        let phrase = "Paryż"
        
        networkingService.citiesToReturn = createMockCities()
        sut.citiesListChanged
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.searchForCities(with: phrase)
        sut.searchForCities(with: "")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.cities, [])
    }
    
    func test_dataFetchedCorrectly() {
        let expectation = XCTestExpectation(description: "citiesListChanged")
        let phrase = "Test"
        
        sut.citiesListChanged
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.searchForCities(with: phrase)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_dataDidNotFetch() {
        let expectation = XCTestExpectation(description: "downloadingErrorOccured")
        let phrase = "Test"
        
        sut.downloadingErrorOccured
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        networkingService.errorToReturn = .downloadingError
        sut.searchForCities(with: phrase)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_dataFetchedCorrectly_citiesAreDownloadingEventReceived() {
        let expectation = XCTestExpectation(description: "citiesAreDownloading")
        let phrase = "Test"
        
        sut.citiesAreDownloading
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.searchForCities(with: phrase)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_ataDidNotFetch_citiesAreDownloadingEventReceived() {
        let expectation = XCTestExpectation(description: "citiesAreDownloading")
        let phrase = "Test"
        
        sut.citiesAreDownloading
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        networkingService.errorToReturn = .wrongURL
        sut.searchForCities(with: phrase)
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Methods
    
    private func createMockCities() -> [City] {
        [City(area: AdministrativeArea(name: "Paryż"), country: Country(name: "Francja"), key: "2684470", name: "Paryż", rank: 20),
         City(area: AdministrativeArea(name: "Kujawsko-Pomorskie"), country: Country(name: "Polska"), key: "2714049", name: "Paryż", rank: 85)]
    }
    
}
