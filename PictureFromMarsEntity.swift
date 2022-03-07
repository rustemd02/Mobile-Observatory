//
//  PictureFromMarsEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData


public class PictureFromMarsEntity: NSManagedObject {

}

extension PictureFromMarsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureFromMarsEntity> {
        return NSFetchRequest<PictureFromMarsEntity>(entityName: "PictureFromMarsEntity")
    }

    @NSManaged public var picture: Data?
    @NSManaged public var rover: String?
    @NSManaged public var date: Date?

}

extension PictureFromMarsEntity : Identifiable {

}
