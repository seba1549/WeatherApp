//
//  HomeViewController+WeatherDetailsDelegate.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Extension containing all methods related to the delegation of commands from the weather details view.
extension HomeViewController: WeatherDetailsDelegate {
    
    func didDissmisView() {
        self.dismiss(animated: true)
    }
    
}
