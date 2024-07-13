//
//  URLProviderTests.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Foundation
import XCTest

@testable import WeatherApp

final class URLProviderTests: XCTestCase {

    // MARK: - Properties
    
    private var sut: URLProvider!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        sut = URLProvider()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Tests
    
    func test_locationsURL() {
        let url = sut.locationsURL
        XCTAssertEqual(url.absoluteString, "https://dataservice.accuweather.com/locations/v1/search")
    }
    
    func test_createWeatherDataURL() {
        let cityKey = "342567"
        let url = sut.createWeatherDataURL(with: cityKey)
        XCTAssertEqual(url.absoluteString, "https://dataservice.accuweather.com/currentconditions/v1/\(cityKey)")
    }
    
}
