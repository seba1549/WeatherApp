//
//  Temperature.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import UIKit
import Foundation

/// Rounded value in specified units. May be nil.
struct Temperature: Decodable, Equatable {
    
    // MARK: - Properties
    
    let metric: Metric
    
    // MARK: - API
    
    var temperatureTextColor: UIColor {
        guard let temperature = metric.value?.rounded() else { return .label }
        switch temperature {
        case _ where temperature < 10: return .systemBlue
        case _ where temperature >= 10 && temperature < 20: return .black
        default: return .systemRed
        }
    }
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        case metric = "Metric"
        
    }
    
}
