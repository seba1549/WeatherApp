//
//  WeatherDataRepository.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Combine
import Foundation

/// Repository responsible for providing the relevant weather data..
final class WeatherDataRepository: AnyWeatherDataRepository {
    
    // MARK: - Properties
    
    private let networkingService: AnyWeatherDataNetworkingService
    
    private(set) var weatherData: WeatherData?
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Publishers
    
    lazy var weatherDataRequested = _weatherDataRequested.eraseToAnyPublisher()
    private lazy var _weatherDataRequested = PassthroughSubject<String, Never>()
    
    lazy var weatherDataFetched = _weatherDataFetched.eraseToAnyPublisher()
    private lazy var _weatherDataFetched = PassthroughSubject<Void, Never>()
    
    lazy var downloadingErrorOccured = _downloadingErrorOccured.eraseToAnyPublisher()
    private lazy var _downloadingErrorOccured = PassthroughSubject<Void, Never>()
    
    // MARK: - Lifecycle
    
    init(networkingService: AnyWeatherDataNetworkingService) {
        self.networkingService = networkingService
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
                guard !cityKey.isEmpty else {
                    weatherData = nil
                    _downloadingErrorOccured.send()
                    return
                }
                
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
            }
            .store(in: &cancellables)
    }
    
}
