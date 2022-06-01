//
//  WeatherOnMarsInfoEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

public class WeatherOnMarsInfoEntity: NSManagedObject {
    
}

extension WeatherOnMarsInfoEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherOnMarsInfoEntity> {
        return NSFetchRequest<WeatherOnMarsInfoEntity>(entityName: "WeatherOnMarsInfoEntity")
    }
    
    @NSManaged public var id: NSNumber
    @NSManaged public var atmoOpacity: String?
    @NSManaged public var earthDate: Date?
    @NSManaged public var maxTemp: NSNumber
    @NSManaged public var minTemp: NSNumber
    @NSManaged public var monthOnMars: String?
    @NSManaged public var pressure: NSNumber
    @NSManaged public var pressureString: String?
    @NSManaged public var sol: NSNumber
    
}

extension WeatherOnMarsInfoEntity : Identifiable {
    
    func update(with weatherInfo: WeatherOnMarsInfo) {
        sol = NSNumber(value: weatherInfo.sol)
        atmoOpacity = weatherInfo.atmoOpacity
        earthDate = weatherInfo.earthDate
        maxTemp = NSNumber(value: weatherInfo.maxTemp)
        minTemp = NSNumber(value: weatherInfo.minTemp)
        monthOnMars = weatherInfo.monthOnMars
        pressure = NSNumber(value: weatherInfo.pressure)
        pressureString = weatherInfo.pressureString
    }
    
    func convertToFeedEntity() -> WeatherOnMarsInfo {
         var weatherOnMars = WeatherOnMarsInfo(id: Int(truncating: self.id),
                                 sol: Int(truncating: self.sol),
                                 earthDate: earthDate!,
                                 minTemp: Int(truncating: self.minTemp),
                                 maxTemp: Int(truncating: self.maxTemp),
                                 pressure: Int(truncating: self.pressure),
                                 pressureString: pressureString ?? "",
                                 atmoOpacity: atmoOpacity!,
                                 monthOnMars: monthOnMars ?? "")
        weatherOnMars.isSaved = true
        return weatherOnMars
    }
}
