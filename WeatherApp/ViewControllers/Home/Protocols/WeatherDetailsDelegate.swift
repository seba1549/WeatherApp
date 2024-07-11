//
//  WeatherDetailsDelegate.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import Foundation

/// Delegate for `WeatherDetails` allowing backward communication with the main application view.
protocol WeatherDetailsDelegate {
    
    /// A method that informs the main view that it is to desmiss the weather preview at a pre-selected location.
    func didDissmisView()
    
}
