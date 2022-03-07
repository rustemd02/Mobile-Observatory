//
//  NearEarthAsteroidsEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData


public class NearEarthAsteroidsEntity: NSManagedObject {

}

extension NearEarthAsteroidsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NearEarthAsteroidsEntity> {
        return NSFetchRequest<NearEarthAsteroidsEntity>(entityName: "NearEarthAsteroidsEntity")
    }

    @NSManaged public var prevLink: String?
    @NSManaged public var nextLink: String?
    @NSManaged public var id: NSNumber
    @NSManaged public var asteroids: NSSet?

}

// MARK: Generated accessors for asteroids
extension NearEarthAsteroidsEntity {

    @objc(addAsteroidsObject:)
    @NSManaged public func addToAsteroids(_ value: AsteroidEntity)

    @objc(removeAsteroidsObject:)
    @NSManaged public func removeFromAsteroids(_ value: AsteroidEntity)

    @objc(addAsteroids:)
    @NSManaged public func addToAsteroids(_ values: NSSet)

    @objc(removeAsteroids:)
    @NSManaged public func removeFromAsteroids(_ values: NSSet)

}

extension NearEarthAsteroidsEntity : Identifiable {

}
