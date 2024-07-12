//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 12/07/2024.
//

import Foundation
import UIKit

/// View of weather details.
final class WeatherDetailsView: UIView {
    
    // MARK: - Properties
    
    /// Information on the chosen city.
    let city: City
    
    /// Information on the weather in the selected city.
    let weatherData: WeatherData
    
    // MARK: - Subviews
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        return stack
    }()
    
    // MARK: - General information subviews
    
    private lazy var generalInformationStack: UIStackView = {
        let stack = UIStackView()
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 3
        stack.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        return stack
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 60, weight: .thin)
        return label
    }()
    
    private lazy var weatherTextLabel = createInformationLabel()
    private lazy var minAndMaxTemperatureLabel = createInformationLabel()
    
    // MARK: - Secondary information subviews
    
    private lazy var secondaryInformationStack: UIStackView = {
        let stack = UIStackView()
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        stack.backgroundColor = .tertiarySystemBackground
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    private lazy var realFeelTemperatureView = KeyAndValueView()
    private lazy var cloudCoverView = KeyAndValueView()
    private lazy var relativeHumidityView = KeyAndValueView()
    private lazy var windView = KeyAndValueView()
    private lazy var visibilityView = KeyAndValueView()
    private lazy var pressureView = KeyAndValueView()
    
    // MARK: - Lifecycle
    
    init(city: City, weatherData: WeatherData) {
        self.city = city
        self.weatherData = weatherData
        super.init(frame: .zero)
        
        setupView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(mainStack)
        
        mainStack.addArrangedSubview(generalInformationStack)
        generalInformationStack.addArrangedSubview(cityNameLabel)
        generalInformationStack.addArrangedSubview(temperatureLabel)
        generalInformationStack.addArrangedSubview(weatherTextLabel)
        generalInformationStack.addArrangedSubview(minAndMaxTemperatureLabel)
        
        mainStack.addArrangedSubview(secondaryInformationStack)
        secondaryInformationStack.addArrangedSubview(realFeelTemperatureView)
        secondaryInformationStack.addArrangedSubview(cloudCoverView)
        secondaryInformationStack.addArrangedSubview(relativeHumidityView)
        secondaryInformationStack.addArrangedSubview(windView)
        secondaryInformationStack.addArrangedSubview(visibilityView)
        secondaryInformationStack.addArrangedSubview(pressureView)
        
        mainStack.addArrangedSubview(UIView())
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureView() {
        cityNameLabel.text = city.name
        temperatureLabel.text = weatherData.formattedTemperature
        weatherTextLabel.text = weatherData.weatherText
        
        if let temperature = weatherData.temperature {
            temperatureLabel.textColor = temperature.temperatureTextColor
        }
        
        let minTemperature = weatherData.formattedMinTemperatureSummary
        let maxTemperature = weatherData.formattedMaxTemperatureSummary
        minAndMaxTemperatureLabel.text = "od \(minTemperature) do \(maxTemperature)"
        
        let realFeelTemperature = weatherData.formattedRealFeelTemperature
        realFeelTemperatureView.configureView(key: "Temperatura odczuwalna", value: realFeelTemperature)
        cloudCoverView.configureView(key: "Zachmurzenie", value: weatherData.formattedCloudCover)
        relativeHumidityView.configureView(key: "Wilgotność względna", value: weatherData.formattedRelativeHumidity)
        windView.configureView(key: "Wiatr", value: weatherData.formattedWindSpeed)
        visibilityView.configureView(key: "Widoczność", value: weatherData.formattedVisibility)
        pressureView.configureView(key: "Ciśnienie", value: weatherData.formattedPressure)
    }
    
    private func createInformationLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }
    
}
