//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Combine
import UIKit

final class WeatherDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let repository = WeatherDataRepository()
    private let city: City
    
    var delegate: WeatherDetailsDelegate?
    
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Lifecycle
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        repository.fetchWeatherData(for: city.key)
    }
    
    // MARK: - Methods
    
    private func setupView() {
        setupNavBar()
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupNavBar() {
        let closeBarButtonItem = UIBarButtonItem(title: "Anuluj", style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    private func configureViewWithWeatherDate() {
        guard let weatherData = repository.weatherData else { return }
        title = weatherData.weatherText
        // TODO: - Tutaj trzeba zrobić konfigurację widoku po pobraniu danych.
    }

    @objc private func popViewController() {
        delegate?.didDissmisView()
    }
    
    private func bind() {
        repository.weatherDataFetched
            .sink { [weak self] weatherData in
                guard let self else { return }
                configureViewWithWeatherDate()
            }
            .store(in: &cancellables)
    }
    
}
