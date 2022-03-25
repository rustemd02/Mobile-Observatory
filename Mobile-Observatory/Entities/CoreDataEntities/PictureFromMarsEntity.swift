//
//  PictureFromMarsEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(PictureFromMarsEntity)
public class PictureFromMarsEntity: NSManagedObject {

}

extension PictureFromMarsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureFromMarsEntity> {
        return NSFetchRequest<PictureFromMarsEntity>(entityName: "PictureFromMarsEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var picture: String?
    @NSManaged public var rover: String?
    @NSManaged public var id: NSNumber

}

extension PictureFromMarsEntity : Identifiable {

}

