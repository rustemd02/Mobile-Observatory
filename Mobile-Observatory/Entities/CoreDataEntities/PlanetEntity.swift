////
////  PlanetEntity+CoreDataProperties.swift
////  Mobile-Observatory
////
////  Created by andrewoch on 27.03.2022.
////
////
//
//import Foundation
//import CoreData
//
//public class PlanetEntity: NSManagedObject {
//    
//}
//
//extension PlanetEntity {
//    
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetEntity> {
//        return NSFetchRequest<PlanetEntity>(entityName: "PlanetEntity")
//    }
//    
//    @NSManaged public var id: UUID
//    @NSManaged public var bodyType: String?
//    @NSManaged public var discoveredWhen: Date?
//    @NSManaged public var gravity: NSNumber
//    @NSManaged public var mass: NSNumber
//    @NSManaged public var name: String?
//    @NSManaged public var radius: NSNumber
//    @NSManaged public var moons: NSSet?
//    
//}
//
//// MARK: Generated accessors for moons
//extension PlanetEntity {
//    
//    @objc(addMoonsObject:)
//    @NSManaged public func addToMoons(_ value: MoonEntity)
//    
//    @objc(removeMoonsObject:)
//    @NSManaged public func removeFromMoons(_ value: MoonEntity)
//    
//    @objc(addMoons:)
//    @NSManaged public func addToMoons(_ values: NSSet)
//    
//    @objc(removeMoons:)
//    @NSManaged public func removeFromMoons(_ values: NSSet)
//    
//}
//
//extension PlanetEntity : Identifiable {
//    
//    func update(with planet: Planet) {
//        
//        name = planet.name
//        bodyType = planet.bodyType
//        discoveredWhen = planet.discoveredWhen
//        gravity = NSNumber(value: planet.gravity)
//        mass = NSNumber(value: planet.mass)
//        radius = NSNumber(value: planet.radius)
//    }
//    
//    func convertToFeedEntity() -> Planet {
//        // swiftlint:disable:next force_cast
//        return Planet(name: name!,
//                      moons: moons?.allObjects as! [String],
//                      mass: Float(truncating: mass),
//                      radius: Float(truncating: radius),
//                      discoveredWhen: discoveredWhen,
//                      gravity: Float(truncating: gravity),
//                      bodyType: bodyType!)
//    }
//}
