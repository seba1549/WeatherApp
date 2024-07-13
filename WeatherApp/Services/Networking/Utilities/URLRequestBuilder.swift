//
//  URLRequestBuilder.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// The structure responsible for preparing the requests needed to make enquiries.
struct URLRequestBuilder {
    
    // MARK: - Proeprties
    
    private static let urlProvider = URLProvider()
    
    // MARK: - API
    
    /// Responsible for creating the request used to retrieve city data.
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
    
    /// Responsible for creating the request used to retrieve the weather data.
    static func createWeatherDataRequest(for cityKey: String) -> URLRequest? {
        let url = urlProvider.createWeatherDataURL(with: cityKey)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "apikey", value: Constants.apiKey),
            URLQueryItem(name: "language", value: "pl"),
            URLQueryItem(name: "details", value: "true")
        ]
        
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
    
}
