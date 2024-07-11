//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let citiesRepository = CitiesRepository(networkingService: NetworkingService())
        
        let mainViewController = HomeViewController(citiesRepository: citiesRepository)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
    
}

