//
//  ResponseValidator.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// The structure responsible for validating the response from the server.
struct ResponseValidator {
    
    static func validate(_ response: URLResponse?) throws {
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.wrongServerResponse
        }
    }
    
}
