//
//  NetworkingService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

// TODO: - Klasa do refactoru
final class NetworkingService: AnyNetworkingService {
    
    // MARK: - API
    
    func fetchCities(phrase: String, completionHandler: @escaping (Result<[City], NetworkingError>) -> ()) {
        let link = "https://dataservice.accuweather.com/locations/v1/search?apikey=xgozIFzmA3lCWQZzIdkBuEM1G8C6Z6Vi&q=\(phrase)&language=pl"
        guard let url = URL(string: link) else {
            completionHandler(.failure(.wrongURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300,
                  let data = data else {
                      completionHandler(.failure(.downloadingError))
                      return
                  }
            
            do {
                let decodedData = try JSONDecoder().decode([City].self, from: data)
                completionHandler(.success(decodedData))
            } catch let error {
                print("Decoding error: \(error)")
                completionHandler(.failure(.downloadingError))
            }
        }
        .resume()
    }
    
}
