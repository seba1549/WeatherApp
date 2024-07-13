//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// It contains all the information about the weather at the selected location that is needed to build the view.
struct WeatherData: Decodable, Equatable {
    
    // MARK: - Properties
    
    /// Phrase description of the current weather condition.
    let weatherText: String
    
    /// Relative humidity.
    private let relativeHumidity: Int?
    
    /// Number representing the percentage of the sky that is covered by clouds.
    private let cloudCover: Int?
    
    let temperature: Temperature?
    private let realFeelTemperature: RealFeelTemperature
    private let wind: Wind
    private let visibility: Visibility
    private let pressure: Pressure
    private let temperatureSummary: TemperatureSummary
    
    // MARK: - Lifecycle
    
    init(weatherText: String, 
         relativeHumidity: Int?,
         cloudCover: Int?,
         temperature: Temperature?,
         realFeelTemperature: RealFeelTemperature,
         wind: Wind,
         visibility: Visibility,
         pressure: Pressure,
         temperatureSummary: TemperatureSummary) {
        self.weatherText = weatherText
        self.relativeHumidity = relativeHumidity
        self.cloudCover = cloudCover
        self.temperature = temperature
        self.realFeelTemperature = realFeelTemperature
        self.wind = wind
        self.visibility = visibility
        self.pressure = pressure
        self.temperatureSummary = temperatureSummary
    }
    
    // MARK: - API
    
    /// Current temperature value as double.
    var temperatureValue: Double? { temperature?.metric.value }
    
    /// Temperature formatted to a caption, including value and unit.
    var formattedTemperature: String { getFormattedTemperature(temperature?.metric.value) }
    
    /// Real feel temperature formatted to a caption, including value and unit.
    var formattedRealFeelTemperature: String { getFormattedTemperature(realFeelTemperature.metric.value) }
    
    /// Max temperature summary formatted to a caption, including value and unit.
    var formattedMaxTemperatureSummary: String { getFormattedTemperature(temperatureSummary.past24HourRange.maximum.metric.value) }
    
    /// Min temperature summary formatted to a caption, including value and unit.
    var formattedMinTemperatureSummary: String { getFormattedTemperature(temperatureSummary.past24HourRange.minimum.metric.value) }
    
    /// Wind speed formatted to a caption, including value and unit.
    var formattedWindSpeed: String { formatMetricToString(wind.speed.metric) }
    
    /// Visibility formatted to a caption, including value and unit.
    var formattedVisibility: String { formatMetricToString(visibility.metric) }
    
    /// Pressure formatted to a caption, including value and unit.
    var formattedPressure: String { formatMetricToString(pressure.metric) }
    
    /// Cloud cover formatted to a caption, including value and unit.
    var formattedCloudCover: String {
        guard let cloudCover else { return .dash }
        return "\(cloudCover)%"
    }
    
    /// Relative humidity formatted to a caption, including value and unit.
    var formattedRelativeHumidity: String {
        guard let relativeHumidity else { return .dash }
        return "\(relativeHumidity)%"
    }
    
    // MARK: - Methods
    
    // 
    private func getFormattedTemperature(_ value: Double?) -> String {
        guard let temperature = value?.rounded() else { return .dash }
        return "\(Int(temperature))°"
    }
    
    private func formatMetricToString(_ metric: Metric?) -> String {
        guard let metric, let value = metric.value else { return "Brak informacji" }
        return "\(Int(value)) \(metric.unit)"
    }
    
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
