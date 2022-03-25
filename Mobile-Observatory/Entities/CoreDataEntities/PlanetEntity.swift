//
//  PlanetEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(PlanetEntity)
public class PlanetEntity: NSManagedObject {

}

extension PlanetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetEntity> {
        return NSFetchRequest<PlanetEntity>(entityName: "PlanetEntity")
    }

    @NSManaged public var bodyType: String?
    @NSManaged public var discoveredWhen: Date?
    @NSManaged public var gravity: NSNumber?
    @NSManaged public var mass: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var radius: NSNumber?
    @NSManaged public var id: NSNumber
    @NSManaged public var moons: NSSet?

}

// MARK: Generated accessors for moons
extension PlanetEntity {

    @objc(addMoonsObject:)
    @NSManaged public func addToMoons(_ value: MoonEntity)

    @objc(removeMoonsObject:)
    @NSManaged public func removeFromMoons(_ value: MoonEntity)

    @objc(addMoons:)
    @NSManaged public func addToMoons(_ values: NSSet)

    @objc(removeMoons:)
    @NSManaged public func removeFromMoons(_ values: NSSet)

}

extension PlanetEntity : Identifiable {

}
