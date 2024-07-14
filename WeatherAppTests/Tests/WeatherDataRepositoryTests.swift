//
//  WeatherDataRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Combine
import Foundation
import XCTest

@testable import WeatherApp

/// Class containing tests for `WeatherDataRepository`.
final class WeatherDataRepositoryTests: XCTestCase {

    // MARK: - Properties
    
    private var sut: AnyWeatherDataRepository!
    private var networkingService: MockWeatherDataNetworkingService!
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Lifecycle
    
    override func setUp() {
        let networkingService = MockWeatherDataNetworkingService()
        sut = WeatherDataRepository(networkingService: networkingService)
        self.networkingService = networkingService
        cancellables = [AnyCancellable]()
    }
    
    override func tearDown() {
        networkingService = nil
        sut = nil
        cancellables = [AnyCancellable]()
    }
    
    // MARK: - Tests
    
    func test_fetchWeatherData() {
        let expectation = XCTestExpectation(description: "weatherDataRequested")
        let cityKey = "342567"
        
        sut.weatherDataRequested
            .sink { text in
                XCTAssertEqual(text, cityKey)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchWeatherData(for: cityKey)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchWeatherData_downloadingWithPhrase() {
        let expectation = XCTestExpectation(description: "weatherDataRequested")
        let cityKey = "342567"
        
        networkingService.weatherDataToReturn = createMockWeatherData()
        sut.weatherDataRequested
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchWeatherData(for: cityKey)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.weatherData, createMockWeatherData())
    }
    
    func test_fetchWeatherData_downloadingWithEmptyPhrase() {
        let expectation = XCTestExpectation(description: "weatherDataRequested")
        let cityKey = "342567"
        
        networkingService.weatherDataToReturn = createMockWeatherData()
        sut.weatherDataRequested
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchWeatherData(for: cityKey)
        sut.fetchWeatherData(for: "")
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.weatherData, nil)
    }
    
    func test_fetchWeatherData_dataDidNotFetch() {
        let expectation = XCTestExpectation(description: "downloadingErrorOccured")
        let cityKey = "342567"
        
        networkingService.errorToReturn = .downloadingError
        sut.downloadingErrorOccured
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchWeatherData(for: cityKey)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.weatherData, nil)
    }
    
    // MARK: - Methods
    
    private func createMockWeatherData() -> WeatherData {
        WeatherData(weatherText: "Zachmurzenie duże",
                    relativeHumidity: 52,
                    cloudCover: 76,
                    temperature: Temperature(metric: Metric(value: 7.9, unit: "C")),
                    realFeelTemperature: RealFeelTemperature(metric: RealFeelMetric(value: 30.5, unit: "C")),
                    wind: Wind(speed: Speed(metric: Metric(value: 12.6, unit: "km/h"))),
                    visibility: Visibility(metric: Metric(value: 24.1, unit: "km")),
                    pressure: Pressure(metric: Metric(value: 1015, unit: "mb")),
                    temperatureSummary: TemperatureSummary(past24HourRange: TemperatureRange(minimum: Minimum(metric: Metric(value: 18.7, unit: "C")),
                                                                                             maximum: Maximum(metric: Metric(value: 33.6, unit: "C")))))
    }
    
}
