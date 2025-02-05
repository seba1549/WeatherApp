//
//  HomeViewController+TableView.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation
import UIKit

/// Extension containing all TableView-related methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repository.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as? CityCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: repository.cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = repository.cities[indexPath.row]
        repository.addCityToSearchHistory(city)
        let viewController = WeatherDetailsViewController(city: city)
        viewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: viewController)
        showDetailViewController(navigationController, sender: .none)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
