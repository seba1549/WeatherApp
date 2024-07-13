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
    
    // MARK: - Tests
    
    func test_locationsURL() {
        let url = URLProvider.locationsURL
        XCTAssertEqual(url.absoluteString, "https://dataservice.accuweather.com/locations/v1/search")
    }
    
    func test_createWeatherDataURL() {
        let cityKey = "342567"
        let url = URLProvider.createWeatherDataURL(with: cityKey)
        XCTAssertEqual(url.absoluteString, "https://dataservice.accuweather.com/currentconditions/v1/\(cityKey)")
    }
    
}
