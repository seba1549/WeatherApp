//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: WeatherDetailsDelegate?
    
    private let city: City
    
    // MARK: - Lifecycle
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

    @objc private func popViewController() {
        delegate?.didDissmisView()
    }
    
}
