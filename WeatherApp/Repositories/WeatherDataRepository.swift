//
//  WeatherDataRepository.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Combine
import Foundation

final class WeatherDataRepository {
    
    // MARK: - Properties
    
    private let networkingService = WeatherDataNetworkingService()
    
    private(set) var weatherData: WeatherData?
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Publishers
    
    private lazy var weatherDataRequested = _weatherDataRequested.eraseToAnyPublisher()
    private lazy var _weatherDataRequested = PassthroughSubject<String, Never>()
    
    lazy var weatherDataFetched = _weatherDataFetched.eraseToAnyPublisher()
    private lazy var _weatherDataFetched = PassthroughSubject<Void, Never>()
    
    lazy var downloadingErrorOccured = _downloadingErrorOccured.eraseToAnyPublisher()
    private lazy var _downloadingErrorOccured = PassthroughSubject<Void, Never>()
    
    // MARK: - Lifecycle
    
    init() {
        bind()
    }
    
    // MARK: - API
    
    func fetchWeatherData(for cityKey: String) {
        _weatherDataRequested.send(cityKey)
    }
    
    // MARK: - Methods
    
    private func bind() {
        weatherDataRequested
            .sink { [weak self] cityKey in
                guard let self else { return }
                
                networkingService.fetchWeatherData(cityKey: cityKey) { result in
                    switch result {
                    case let .success(weatherData):
                        self.weatherData = weatherData
                        self._weatherDataFetched.send()
                    case .failure:
                        self.weatherData = nil
                        self._downloadingErrorOccured.send()
                    }
                }
                
//                weatherData = createMockWeatherData()
//                _weatherDataFetched.send()
            }
            .store(in: &cancellables)
    }
    
    // TODO: - To będzie do usunięcia kiedy powstanie warstwa networkingu.
    private func createMockWeatherData() -> WeatherData {
        WeatherData(
            weatherText: "Zachmurzenie duże",
            relativeHumidity: 52,
            cloudCover: 76,
            temperature: Temperature(
                metric: Metric(value: 7.9, unit: "C")
            ),
            realFeelTemperature: RealFeelTemperature(
                metric: RealFeelMetric(value: 30.5, unit: "C")
            ),
            wind: Wind(
                speed: Speed(
                    metric: Metric(value: 12.6, unit: "km/h")
                )
            ),
            visibility: Visibility(
                metric: Metric(value: 24.1, unit: "km")
            ),
            pressure: Pressure(
                metric: Metric(value: 1015, unit: "mb")
            ),
            temperatureSummary: TemperatureSummary(
                past24HourRange: TemperatureRange(
                    minimum: Minimum(
                        metric: Metric(value: 18.7, unit: "C")
                    ),
                    maximum: Maximum(
                        metric: Metric(value: 33.6, unit: "C")
                    )
                )
            )
        )
    }
    
}
