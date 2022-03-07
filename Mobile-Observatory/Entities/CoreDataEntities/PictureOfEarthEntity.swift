//
//  PictureOfEarthEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData


public class PictureOfEarthEntity: NSManagedObject {

}

extension PictureOfEarthEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureOfEarthEntity> {
        return NSFetchRequest<PictureOfEarthEntity>(entityName: "PictureOfEarthEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var latitude: NSNumber
    @NSManaged public var longtitude: NSNumber

}

extension PictureOfEarthEntity : Identifiable {

}
