//
//  ViewState.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation

/// The states a view can take.
enum ViewState {
    
    /// The state when the view is correctly loaded and displays the relevant content.
    case correctlyLoaded
    
    /// State when a view has not been loaded correctly and displays a message to that effect.
    case information(headline: String, subheadline: String)
    
    /// The state in which the view reads the relevant information necessary for it to function correctly.
    case loading
    
}
