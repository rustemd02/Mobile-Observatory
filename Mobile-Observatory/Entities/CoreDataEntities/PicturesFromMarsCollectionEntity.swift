//
//  PicturesFromMarsCollectionEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(PicturesFromMarsCollectionEntity)
public class PicturesFromMarsCollectionEntity: NSManagedObject {

}

extension PicturesFromMarsCollectionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PicturesFromMarsCollectionEntity> {
        return NSFetchRequest<PicturesFromMarsCollectionEntity>(entityName: "PicturesFromMarsCollectionEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var pictures: NSSet?

}

// MARK: Generated accessors for pictures
extension PicturesFromMarsCollectionEntity {

    @objc(addPicturesObject:)
    @NSManaged public func addToPictures(_ value: PictureFromMarsEntity)

    @objc(removePicturesObject:)
    @NSManaged public func removeFromPictures(_ value: PictureFromMarsEntity)

    @objc(addPictures:)
    @NSManaged public func addToPictures(_ values: NSSet)

    @objc(removePictures:)
    @NSManaged public func removeFromPictures(_ values: NSSet)

}

extension PicturesFromMarsCollectionEntity : Identifiable {
    
    func convertToFeedEntity() -> PictureFromMars {
        
        return PictureFromMars(photos: pictures?.allObjects as! [Photo])
    }
}
