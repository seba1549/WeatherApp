//
//  TestCoreDataStack.swift
//  WeatherAppTests
//
//  Created by Sebastian Maludziński on 14/07/2024.
//

import CoreData
import Foundation

///
final class TestCoreDataStack: NSObject {
    
    // MARK: - Properties
    
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "WeatherApp")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}
