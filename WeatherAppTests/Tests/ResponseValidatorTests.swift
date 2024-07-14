//
//  ResponseValidatorTests.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 13/07/2024.
//

import Foundation
import XCTest

@testable import WeatherApp

/// Class containing tests for `ResponseValidator`.
final class ResponseValidatorTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_validate_correctCodeStatus() {
        let url = URL(string: "https://www.google.com")!
        let httpURLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [:])
        
        do {
            try ResponseValidator.validate(httpURLResponse)
        } catch {
            XCTFail("Status code is invalid!")
        }
    }
    
    func test_validate_wrongCodeStatus() {
        let url = URL(string: "https://www.google.com")!
        let httpURLResponse = HTTPURLResponse(url: url, statusCode: 403, httpVersion: nil, headerFields: [:])
        
        do {
            try ResponseValidator.validate(httpURLResponse)
        } catch {
            XCTAssertEqual(error as! NetworkingError, NetworkingError.wrongServerResponse)
        }
    }
    
}
