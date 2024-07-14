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
    
    private lazy var informationView: InformationView = {
        let view = InformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
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
        presentEmptyListInformation()
        
        repository.citiesListChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                loadingView.removeFromSuperview()
                
                guard let searchText = searchBar.text else {
                    presentEmptyListInformation()
                    return
                }
                
                if repository.cities.isEmpty, searchText.isEmpty {
                    presentEmptyListInformation()
                } else if !repository.cities.isEmpty, !searchText.isEmpty {
                    viewContainer.view.addSubview(tableView)
                    tableView.widthAnchor.constraint(equalTo: viewContainer.view.widthAnchor).isActive = true
                    tableView.heightAnchor.constraint(equalTo: viewContainer.view.heightAnchor).isActive = true
                    tableView.reloadData()
                } else {
                    presentInformationView(headline: "Brak wyników",
                                           subheadline: "Brak wyników dla \"\(searchBar.text ?? .empty)\"",
                                           icon: .searchLoop)
                }
            }
            .store(in: &cancellables)
        
        repository.downloadingErrorOccured
            .sink { [weak self] in
                guard let self else { return }
                presentInformationView(headline: "Wystąpił błąd pobierania",
                                       subheadline: "Spróbuj ponownie później",
                                       icon: .exclamationMark)
            }
            .store(in: &cancellables)
        
        repository.citiesAreDownloading
            .sink { [weak self] in
                guard let self else { return }
                informationView.removeFromSuperview()
                viewContainer.view.addSubview(loadingView)
                loadingView.centerXAnchor.constraint(equalTo: viewContainer.view.centerXAnchor).isActive = true
                loadingView.centerYAnchor.constraint(equalTo: viewContainer.view.centerYAnchor).isActive = true
            }
            .store(in: &cancellables)
        
        repository.userSearchedForCities
            .sink { [weak self] _ in
                guard let self else { return }
                tableView.removeFromSuperview()
            }
            .store(in: &cancellables)
    }
    
    /// Presents a message about an empty list of cities.
    private func presentEmptyListInformation() {
        presentInformationView(subheadline: "Zacznij wpisywać nazwę miejscowości aby rozpocząć wyszukiwanie.")
    }
    
    /// Presents a view of the information with the selected message.
    private func presentInformationView(headline: String? = nil, subheadline: String? = nil, icon: AppIcon? = nil) {
        informationView.reconfigureView(headline: headline, subheadline: subheadline, icon: icon)
        viewContainer.view.addSubview(informationView)
        informationView.centerXAnchor.constraint(equalTo: viewContainer.view.centerXAnchor).isActive = true
        informationView.centerYAnchor.constraint(equalTo: viewContainer.view.centerYAnchor).isActive = true
    }
    
}
