//
//  CitiesRepository.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Combine
import Foundation

/// Repository responsible for providing the relevant list of cities.
final class CitiesRepository {
    
    // MARK: - Properties
    
    private let networkingService: AnyCitiesNetworkingService
    private(set) var cities = [City]()
    
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Publishers
    
    private lazy var userSearchedForCities = _userSearchedForCities.eraseToAnyPublisher()
    private lazy var _userSearchedForCities = PassthroughSubject<String, Never>()
    
    lazy var citiesListChanged = _citiesListChanged.eraseToAnyPublisher()
    private lazy var _citiesListChanged = PassthroughSubject<Void, Never>()
    
    lazy var downloadingErrorOccured = _downloadingErrorOccured.eraseToAnyPublisher()
    private lazy var _downloadingErrorOccured = PassthroughSubject<Void, Never>()

    
    // MARK: - Lifecycle
    
    init(networkingService: AnyCitiesNetworkingService) {
        self.networkingService = networkingService
        bind()
    }
    
    // MARK: - API
    
    func searchForCities(with phrase: String) {
        _userSearchedForCities.send(phrase)
    }
    
    // MARK: - Methods
    
    private func bind() {
        userSearchedForCities
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] phrase in
                guard let self = self else { return }
                guard !phrase.isEmpty else {
                    self.cities = []
                    _citiesListChanged.send()
                    return
                }
                
                self.cities = [City(area: AdministrativeArea(name: "Paryż"), country: Country(name: "Francja"), key: "2684470", name: "Paryż", rank: 20),
                               City(area: AdministrativeArea(name: "Kujawsko-Pomorskie"), country: Country(name: "Polska"), key: "2714049", name: "Paryż", rank: 85)]
                self._citiesListChanged.send()
                
//                networkingService.fetchCities(phrase: phrase) { result in
//                    switch result {
//                    case let .success(cities):
//                        self.cities = cities
//                        self._citiesListChanged.send()
//                    case .failure:
//                        self.cities = []
//                        self._downloadingErrorOccured.send()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
}
