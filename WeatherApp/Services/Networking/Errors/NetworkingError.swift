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
    
    /// An error occurring when, for some reason, the data could not be downloaded.
    case downloadingError
    
    /// Error occurring when the server response is incorrect.
    case wrongServerResponse
    
    /// Error occurring when the URL is invalid.
    case wrongURL
    
    // MARK: - Properties
    
    var errorDescription: String? {
        switch self {
        case .downloadingError: NSLocalizedString("An error occurred while downloading data.", comment: .empty)
        case .wrongServerResponse: NSLocalizedString("Incorrect server response.", comment: .empty)
        case .wrongURL: NSLocalizedString("The URL used in the query is not correct.", comment: .empty)
        }
    }
    
}
