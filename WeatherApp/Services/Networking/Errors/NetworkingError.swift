//
//  NetworkingError.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

/// An error that can occur when downloading data from the internet.
enum NetworkingError: LocalizedError {
    
    // MARK: - Cases
    
    /// Error resulting from an incorrect URL.
    case wrongURL
    
    /// Error resulting from failed data download.
    case downloadingError
    
    // MARK: - Properties
    
    var errorDescription: String? {
        switch self {
        case .wrongURL: NSLocalizedString("The URL isn't correct!", comment: "")
        case .downloadingError: NSLocalizedString("There is a problem with data downloading!", comment: "")
        }
    }
    
}
