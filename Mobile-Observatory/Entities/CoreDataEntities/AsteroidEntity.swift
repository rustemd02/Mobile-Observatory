//
//  AsteroidEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

public class AsteroidEntity: NSManagedObject {

}

extension AsteroidEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AsteroidEntity> {
        return NSFetchRequest<AsteroidEntity>(entityName: "AsteroidEntity")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var id: NSNumber?
    @NSManaged public var approachDate: Date?
    @NSManaged public var estimatedDiameter: NSNumber
    @NSManaged public var infoLink: String?
    @NSManaged public var isHazardous: Bool
    @NSManaged public var missDistance: NSNumber
    @NSManaged public var name: String?
    @NSManaged public var velocity: NSNumber
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
    
    func update(with asteroid: Asteroid) {
        uuid = asteroid.uuid
        id = NSNumber(value: asteroid.id)
        approachDate = asteroid.approachDate
        estimatedDiameter = NSNumber(value: asteroid.estimatedDiameter)
        infoLink = asteroid.infoLink.absoluteString
        isHazardous = asteroid.isHazardous
        missDistance = NSNumber(value: asteroid.missDistance)
        velocity = NSNumber(value: asteroid.velocity)
        name = asteroid.name
    }
    
    func convertToFeedEntity() -> Asteroid {
        // swiftlint:disable:next force_cast
        return Asteroid(uuid: uuid, id: id as! Int, name: name!, infoLink: URL.init(fileURLWithPath: infoLink ?? ""), estimatedDiameter: Float(truncating: estimatedDiameter), isHazardous: isHazardous, approachDate: approachDate!, velocity: Float(truncating: velocity), missDistance: Float(truncating: missDistance))
    }
}
