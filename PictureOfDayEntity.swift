//
//  PictureOfDayEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData


public class PictureOfDayEntity: NSManagedObject {

}

extension PictureOfDayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureOfDayEntity> {
        return NSFetchRequest<PictureOfDayEntity>(entityName: "PictureOfDayEntity")
    }

    @NSManaged public var descr: String?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?

}

extension PictureOfDayEntity : Identifiable {

}
