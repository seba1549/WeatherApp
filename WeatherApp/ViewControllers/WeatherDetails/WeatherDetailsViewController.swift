//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Combine
import UIKit

/// ViewController for the weather detail view.
final class WeatherDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Weather data repository.
    private let repository = WeatherDataRepository(networkingService: WeatherDataNetworkingService())
    
    /// Information on the chosen city.
    private let city: City
    
    ///Delegate allowing communication with the weather preview.
    var delegate: WeatherDetailsDelegate?
    
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Subviews
    
    private lazy var viewContainer: UIViewController = {
        let viewController = UIViewController()
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
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
        
        addChild(viewContainer)
        didMove(toParent: self)
        view.addSubview(viewContainer.view)
        
        NSLayoutConstraint.activate([
            viewContainer.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewContainer.view.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: viewContainer.view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: viewContainer.view.centerYAnchor).isActive = true
    }
    
    private func setupNavBar() {
        let closeBarButtonItem = UIBarButtonItem(title: "Anuluj", style: .plain, target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    private func configureViewWithWeatherDate() {
        guard let weatherData = repository.weatherData else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let detailsView = WeatherDetailsView(city: city, weatherData: weatherData)
            detailsView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.removeFromSuperview()
            viewContainer.view.addSubview(detailsView)
            
            detailsView.widthAnchor.constraint(equalTo: viewContainer.view.widthAnchor).isActive = true
        }
    }

    @objc private func popViewController() {
        delegate?.didDissmisView()
    }
    
    private func bind() {
        repository.weatherDataFetched
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weatherData in
                guard let self else { return }
                configureViewWithWeatherDate()
            }
            .store(in: &cancellables)
    }
    
}
