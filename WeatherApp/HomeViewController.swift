//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import UIKit

final class HomeViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Subviews
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Miasto"
        return searchBar
    }()
    
    // MARK: - API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "WeatherApp"
        
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Tu będzie odpalane zapytanie do API o listę miast
        print(searchText)
    }
    
}

