//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import CoreData
import UIKit
import OSLog

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - API
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let coreDataService = CoreDataService(containerPersistent: createPersistentContainer())
        let citiesRepository = CitiesRepository(networkingService: CitiesNetworkingService(),
                                                coreDataService: coreDataService)
        let mainViewController = HomeViewController(repository: citiesRepository)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
    
    // MARK: - Methods
    
    private func createPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                os_log("CoreDataService error:", error.localizedDescription)
            }
        }
        
        return container
    }
    
}

