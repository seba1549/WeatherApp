//
//  HomeViewController+SearchBar.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 11/07/2024.
//

import UIKit
import Foundation

/// Extension containing all search-related methods
extension HomeViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        repository.searchForCities(with: searchText)
    }
    
    // We use [[:alpha:]] because we want to be able to use the letters of all languages - not just Polish.
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: "([[:alpha:]\\s])"),
              regex.firstMatch(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.count)) != nil else {
            return false
        }
        
        return true
    }
    
}
