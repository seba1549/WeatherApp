//
//  CitiesRepository.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Combine
import Foundation

/// Repository responsible for providing the relevant list of cities.
final class CitiesRepository: AnyCitiesRepository {
    
    // MARK: - Properties
    
    private let networkingService: AnyCitiesNetworkingService
    private let coreDataService: AnyCoreDataService
    private(set) var cities = [City]()
    
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Publishers
    
    lazy var userSearchedForCities = _userSearchedForCities.eraseToAnyPublisher()
    private lazy var _userSearchedForCities = PassthroughSubject<String, Never>()
    
    lazy var citiesListChanged = _citiesListChanged.eraseToAnyPublisher()
    private lazy var _citiesListChanged = PassthroughSubject<Void, Never>()
    
    lazy var downloadingErrorOccured = _downloadingErrorOccured.eraseToAnyPublisher()
    private lazy var _downloadingErrorOccured = PassthroughSubject<Void, Never>()

    lazy var citiesAreDownloading = _citiesAreDownloading.eraseToAnyPublisher()
    private lazy var _citiesAreDownloading = PassthroughSubject<Void, Never>()
    
    // MARK: - Lifecycle
    
    init(networkingService: AnyCitiesNetworkingService,
         coreDataService: AnyCoreDataService) {
        self.networkingService = networkingService
        self.coreDataService = coreDataService
        bind()
    }
    
    // MARK: - API
    
    func searchForCities(with phrase: String) {
        _userSearchedForCities.send(phrase)
    }
    
    func addCityToSearchHistory(_ city: City) {
        coreDataService.addCityToSearchHistory(city)
    }
    
    func deleteSearchHistory() {
        coreDataService.deleteSearchHistory()
        cities = []
    }
    
    // MARK: - Methods
    
    private func bind() {
        userSearchedForCities
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] phrase in
                guard let self = self else { return }
                guard !phrase.isEmpty else {
                    cities = coreDataService.fetchSearchHistory()
                    _citiesListChanged.send()
                    return
                }
                
                _citiesAreDownloading.send()
                
                networkingService.fetchCities(phrase: phrase) { result in
                    switch result {
                    case let .success(cities):
                        self.cities = cities.sorted()
                        self._citiesListChanged.send()
                    case .failure:
                        self.cities = []
                        self._downloadingErrorOccured.send()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
}
