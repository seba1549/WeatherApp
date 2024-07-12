//
//  NetworkingService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//


import Foundation
import OSLog

/// Networking set up for city-related enquiries.
final class CitiesNetworkingService: AnyCitiesNetworkingService {
    
    // MARK: - API
    
    func fetchCities(phrase: String, completionHandler: @escaping (Result<[City], NetworkingError>) -> ()) {
        guard let urlRequest = URLRequestBuilder.createLocationsRequest(for: phrase) else {
            completionHandler(.failure(.wrongURL))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            guard error == nil,
                  let data = data else {
                os_log("CitiesNetworkingService error:", error?.localizedDescription ?? .empty)
                completionHandler(.failure(.downloadingError))
                return
            }
            
            do {
                try ResponseValidator.validate(response)
                let decodedData = try JSONDecoder().decode([City].self, from: data)
                completionHandler(.success(decodedData))
            } catch let error {
                os_log("CitiesNetworkingService error:", error.localizedDescription)
                completionHandler(.failure(.downloadingError))
            }
        }
        .resume()
    }
    
}
