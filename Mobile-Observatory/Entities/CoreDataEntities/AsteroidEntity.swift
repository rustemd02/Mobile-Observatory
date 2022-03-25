//
//  AsteroidEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(AsteroidEntity)
public class AsteroidEntity: NSManagedObject {

}

extension AsteroidEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AsteroidEntity> {
        return NSFetchRequest<AsteroidEntity>(entityName: "AsteroidEntity")
    }

    @NSManaged public var approachDate: Date?
    @NSManaged public var estimatedDiameter: NSNumber?
    @NSManaged public var id: NSNumber
    @NSManaged public var infoLink: String?
    @NSManaged public var isHazardous: Bool
    @NSManaged public var missDistance: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var velocity: NSNumber?
    @NSManaged public var nearEarthAsteroids: NSSet?

}

// MARK: Generated accessors for nearEarthAsteroids
extension AsteroidEntity {

    @objc(addNearEarthAsteroidsObject:)
    @NSManaged public func addToNearEarthAsteroids(_ value: NearEarthAsteroidsEntity)

    @objc(removeNearEarthAsteroidsObject:)
    @NSManaged public func removeFromNearEarthAsteroids(_ value: NearEarthAsteroidsEntity)

    @objc(addNearEarthAsteroids:)
    @NSManaged public func addToNearEarthAsteroids(_ values: NSSet)

    @objc(removeNearEarthAsteroids:)
    @NSManaged public func removeFromNearEarthAsteroids(_ values: NSSet)

}

extension AsteroidEntity : Identifiable {

}
