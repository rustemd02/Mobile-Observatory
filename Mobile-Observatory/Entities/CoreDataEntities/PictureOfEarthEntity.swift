//
//  PictureOfEarthEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(PictureOfEarthEntity)
public class PictureOfEarthEntity: NSManagedObject {

}

extension PictureOfEarthEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureOfEarthEntity> {
        return NSFetchRequest<PictureOfEarthEntity>(entityName: "PictureOfEarthEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: String?
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longtitude: NSNumber?
    @NSManaged public var id: NSNumber

}

extension PictureOfEarthEntity : Identifiable {

}
