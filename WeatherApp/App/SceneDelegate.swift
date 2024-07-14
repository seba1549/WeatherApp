//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - API
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let coreDataService = CoreDataService()
        let citiesRepository = CitiesRepository(networkingService: CitiesNetworkingService(),
                                                coreDataService: coreDataService)
        let mainViewController = HomeViewController(repository: citiesRepository)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
    
}

