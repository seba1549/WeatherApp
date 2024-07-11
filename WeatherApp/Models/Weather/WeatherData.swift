//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// It contains all the information about the weather at the selected location that is needed to build the view.
struct WeatherData: Decodable {
    
    // MARK: - Properties
    
    /// Phrase description of the current weather condition.
    let weatherText: String
    
    /// Relative humidity.
    let relativeHumidity: Int?
    
    /// Number representing the percentage of the sky that is covered by clouds.
    let cloudCover: Int?
    
    let temperature: Temperature?
    let realFeelTemperature: RealFeelTemperature
    let wind: Wind
    let visibility: Visibility
    let pressure: Pressure
    let temperatureSummary: TemperatureSummary
    
    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        
        case weatherText = "WeatherText"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case relativeHumidity = "RelativeHumidity"
        case wind = "Wind"
        case visibility = "Visibility"
        case cloudCover = "CloudCover"
        case pressure = "Pressure"
        case temperatureSummary = "TemperatureSummary"
        
    }
    
}
