//
//  AlbumEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(AlbumEntity)
public class AlbumEntity: NSManagedObject {

}

extension AlbumEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumEntity> {
        return NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var datum: SearchResultEntity?

}

extension AlbumEntity : Identifiable {

}
