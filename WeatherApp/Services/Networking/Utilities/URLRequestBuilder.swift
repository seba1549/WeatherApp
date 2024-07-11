//
//  URLRequestBuilder.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

struct URLRequestBuilder {
    
    // MARK: - Proeprties
    
    private static let urlProvider = URLProvider()
    
    // MARK: - API
    
    static func createLocationsRequest(for searchText: String) -> URLRequest? {
        let url = urlProvider.locationsURL
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "apikey", value: Constants.apiKey),
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "language", value: "pl")
        ]
        
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
    
}
