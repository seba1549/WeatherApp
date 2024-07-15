//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 14/07/2024.
//

import CoreData
import Foundation
import OSLog

/// Class managing the CoreData.
final class CoreDataService: AnyCoreDataService {
    
    // MARK: - Properties
    
    let containerPersistent: NSPersistentContainer
    
    // MARK: - Lifecycle
    
    init(containerPersistent: NSPersistentContainer) {
        self.containerPersistent = containerPersistent
    }
    
    // MARK: - API
    
    func fetchSearchHistory() -> [City] {
        do {
            let request = NSFetchRequest<CityEntity>(entityName: "CityEntity")
            return try containerPersistent.viewContext.fetch(request)
                .sorted()
                .map { city in
                    City(area: AdministrativeArea(name: city.areaName),
                         country: Country(name: city.countryName),
                         key: city.key,
                         name: city.name,
                         rank: city.rank)
                }
        } catch let error {
            os_log("CoreDataService error:", error.localizedDescription)
            return []
        }
    }
    
    func addCityToSearchHistory(_ city: City) {
        guard !fetchSearchHistory().contains(where: { $0.key == city.key }) else { return }
        let context = containerPersistent.viewContext
        context.perform {
            let item = CityEntity(context: context)
            item.areaName = city.area.name
            item.countryName = city.country.name
            item.date = Date()
            item.key = city.key
            item.name = city.name
            item.rank = city.rank
            self.saveData(context: context)
        }
    }
    
    func deleteSearchHistory() {
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "CityEntity"))
            let context = containerPersistent.viewContext
            try context.execute(deleteRequest)
            saveData(context: context)
        } catch let error {
            os_log("CoreDataService error:", error.localizedDescription)
        }
    }
    
    // MARK: - Methods
    
    private func saveData(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error {
            os_log("CoreDataService error:", error.localizedDescription)
        }
    }
    
}
