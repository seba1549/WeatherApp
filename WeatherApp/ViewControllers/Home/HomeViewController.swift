//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Combine
import UIKit

/// ViewController supporting the main application screen.
final class HomeViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    
    /// Cities repository.
    let repository: CitiesRepository
    
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Subviews
    
    lazy var tableView = UITableView()
    private lazy var viewContainer = UIViewController()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Miasto"
        return searchBar
    }()
    
    // MARK: - Lifecycle
    
    init(repository: CitiesRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        setupTableView()
        
        view.backgroundColor = .secondarySystemBackground
        title = "WeatherApp"
        
        view.addSubview(searchBar)
        
        viewContainer.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(viewContainer)
        didMove(toParent: self)
        
        view.addSubview(viewContainer.view)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            
            viewContainer.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            viewContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    private func bind() {
        viewContainer.view = createEmptyListView()
        
        repository.citiesListChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                
                guard let searchText = searchBar.text else {
                    viewContainer.view = createEmptyListView()
                    return
                }
                
                if repository.cities.isEmpty, searchText.isEmpty {
                    viewContainer.view = createEmptyListView()
                } else if !repository.cities.isEmpty, !searchText.isEmpty {
                    viewContainer.view = tableView
                    tableView.reloadData()
                } else {
                    viewContainer.view = InformationView(headline: "Brak wyników",
                                                         subheadline: "Brak wyników dla \"\(searchBar.text ?? .empty)\"",
                                                         systemImageName: .searchLoop)
                }
            }
            .store(in: &cancellables)
        
        repository.downloadingErrorOccured
            .sink { [weak self] in
                guard let self else { return }
                viewContainer.view = InformationView(headline: "Wystąpił błąd pobierania",
                                                     subheadline: "Spróbuj ponownie później",
                                                     systemImageName: .exclamationMark)
            }
            .store(in: &cancellables)
        
        repository.citiesAreDownloading
            .sink { [weak self] in
                guard let self else { return }
                viewContainer.view = LoadingView()
            }
            .store(in: &cancellables)
    }
    
    private func createEmptyListView() -> UIView {
        InformationView(subheadline: "Zacznij wpisywać nazwę miejscowości aby rozpocząć wyszukiwanie.")
    }
    
}
