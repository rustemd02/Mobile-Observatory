//
//  WeatherOnMarsInfoEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData

@objc(WeatherOnMarsInfoEntity)
public class WeatherOnMarsInfoEntity: NSManagedObject {

}

extension WeatherOnMarsInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherOnMarsInfoEntity> {
        return NSFetchRequest<WeatherOnMarsInfoEntity>(entityName: "WeatherOnMarsInfoEntity")
    }

    @NSManaged public var sol: NSNumber
    @NSManaged public var earthDate: Date?
    @NSManaged public var minTemp: NSNumber
    @NSManaged public var maxTemp: NSNumber
    @NSManaged public var pressure: NSNumber
    @NSManaged public var pressureString: String?
    @NSManaged public var atmoOpacity: String?
    @NSManaged public var monthOnMars: NSNumber

}

extension WeatherOnMarsInfoEntity : Identifiable {

}
