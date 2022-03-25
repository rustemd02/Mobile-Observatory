//
//  PictureOfDayEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(PictureOfDayEntity)
public class PictureOfDayEntity: NSManagedObject {

}

extension PictureOfDayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureOfDayEntity> {
        return NSFetchRequest<PictureOfDayEntity>(entityName: "PictureOfDayEntity")
    }

    @NSManaged public var descr: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var id: NSNumber

}

extension PictureOfDayEntity : Identifiable {

}
