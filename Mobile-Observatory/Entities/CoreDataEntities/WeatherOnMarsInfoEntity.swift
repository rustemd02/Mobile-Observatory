//
//  WeatherOnMarsInfoEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
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

    @NSManaged public var atmoOpacity: String?
    @NSManaged public var earthDate: Date?
    @NSManaged public var maxTemp: NSNumber?
    @NSManaged public var minTemp: NSNumber?
    @NSManaged public var monthOnMars: NSNumber?
    @NSManaged public var pressure: NSNumber?
    @NSManaged public var pressureString: String?
    @NSManaged public var sol: NSNumber?
    @NSManaged public var id: NSNumber
    

}

extension WeatherOnMarsInfoEntity : Identifiable {

    func update(with weatherInfo: WeatherOnMarsInfo) {
       sol = NSNumber(value: weatherInfo.sol)
       atmoOpacity = weatherInfo.atmoOpacity
       earthDate = weatherInfo.earthDate
       maxTemp = NSNumber(value: weatherInfo.maxTemp)
       minTemp = NSNumber(value: weatherInfo.minTemp)
       monthOnMars = NSNumber(value: weatherInfo.monthOnMars)
       pressure = NSNumber(value: weatherInfo.pressure)
       pressureString = weatherInfo.pressureString
    }
}
