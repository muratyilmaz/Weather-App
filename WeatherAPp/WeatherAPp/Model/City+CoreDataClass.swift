//
//  City+CoreDataClass.swift
//  WeatherAPp
//
//  Created by Murat YILMAZ on 5.06.2018.
//  Copyright © 2018 Murat YILMAZ. All rights reserved.
//
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject {
    
    static func isExist(context: NSManagedObjectContext, cityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        fetchRequest.predicate = NSPredicate(format: "name == %@", cityName)
        var entitiesCount = 0
        do {
            entitiesCount = try context.count(for: fetchRequest)
        }
        catch {
            return false
        }
        return entitiesCount > 0
    }
    
}
