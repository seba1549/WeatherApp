//
//  ResponseValidator.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

struct ResponseValidator {
    
    static func validate(_ response: URLResponse?) throws {
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.wrongServerResponse
        }
    }
    
}
