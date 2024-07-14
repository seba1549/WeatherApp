//
//  CityEntity.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 14/07/2024.
//

import CoreData
import Foundation

@objc(CityEntity)
public class CityEntity: NSManagedObject, Comparable {
    
    // MARK: - Properties
    
    @NSManaged public var areaName: String
    @NSManaged public var countryName: String
    
    /// City search date.
    @NSManaged public var date: Date
    
    @NSManaged public var key: String
    @NSManaged public var name: String
    @NSManaged public var rank: Int
    
    // MARK: - API
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }
    
    public static func < (lhs: CityEntity, rhs: CityEntity) -> Bool {
        lhs.date > rhs.date
    }
    
}
