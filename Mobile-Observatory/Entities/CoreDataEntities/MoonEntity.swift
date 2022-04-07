//
//  MoonEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

public class MoonEntity: NSManagedObject {

}

extension MoonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoonEntity> {
        return NSFetchRequest<MoonEntity>(entityName: "MoonEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var moonName: String?
    @NSManaged public var planet: PlanetEntity?

}

extension MoonEntity : Identifiable {

}
