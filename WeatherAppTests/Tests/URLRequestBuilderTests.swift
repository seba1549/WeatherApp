//
//  URLRequestBuilderTests.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Foundation
import XCTest

@testable import WeatherApp

final class URLRequestBuilderTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_createLocationsRequest() {
        let phrase = "test"
        let urlRequest = URLRequestBuilder.createLocationsRequest(for: phrase)
        
        do {
            let queryItems = try getQueryItemsFrom(urlRequest)
            XCTAssertTrue(queryItems.count == 3)
            XCTAssertTrue(queryItems.contains(where: { $0.name == "apikey" && $0.value == "xgozIFzmA3lCWQZzIdkBuEM1G8C6Z6Vi" })) // To trzeba jakoś zamockować
            XCTAssertTrue(queryItems.contains(where: { $0.name == "language" && $0.value == "pl" }))
            XCTAssertTrue(queryItems.contains(where: { $0.name == "q" && $0.value == phrase }))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_createWeatherDataRequest() {
        let cityKey = "342567"
        let urlRequest = URLRequestBuilder.createWeatherDataRequest(for: cityKey)
        
        do {
            let queryItems = try getQueryItemsFrom(urlRequest)
            XCTAssertTrue(queryItems.count == 3)
            XCTAssertTrue(queryItems.contains(where: { $0.name == "apikey" && $0.value == "xgozIFzmA3lCWQZzIdkBuEM1G8C6Z6Vi" })) // To trzeba jakoś zamockować
            XCTAssertTrue(queryItems.contains(where: { $0.name == "language" && $0.value == "pl" }))
            XCTAssertTrue(queryItems.contains(where: { $0.name == "details" && $0.value == "true" }))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - Methods
    
    private func getQueryItemsFrom(_ urlRequest: URLRequest?) throws -> [URLQueryItem] {
        guard let url = urlRequest?.url else {
            throw NSError(domain: "It was not possible to create a URL.", code: 0)
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let queryItems = urlComponents?.queryItems else {
            throw NSError(domain: "URL does not have components.", code: 0)
        }
        
        return queryItems
    }
    
}
