//
//  WeatherDataNetworkingService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 12/07/2024.
//

import Foundation
import OSLog

/// Networking set up for city-related enquiries.
final class WeatherDataNetworkingService: AnyWeatherDataNetworkingService {
    
    // MARK: - API
    
    func fetchWeatherData(cityKey: String, completionHandler: @escaping (Result<WeatherData, NetworkingError>) -> ()) {
        guard let urlRequest = URLRequestBuilder.createWeatherDataRequest(for: cityKey) else {
            completionHandler(.failure(.wrongURL))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            guard error == nil,
                  let data = data else {
                os_log("WeatherDataNetworkingService error:", error?.localizedDescription ?? .empty)
                completionHandler(.failure(.downloadingError))
                return
            }
            
            do {
                try ResponseValidator.validate(response)
                let decodedData = try JSONDecoder().decode([WeatherData].self, from: data)
                guard let weatherData = decodedData.first else {
                    os_log("WeatherDataNetworkingService error: Blank weather data table.")
                    completionHandler(.failure(.downloadingError))
                    return
                }
                
                completionHandler(.success(weatherData))
            } catch let error {
                os_log("WeatherDataNetworkingService error:", error.localizedDescription)
                completionHandler(.failure(.downloadingError))
            }
        }
        .resume()
    }
    
}
