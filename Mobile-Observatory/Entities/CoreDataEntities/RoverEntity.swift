//
//  RoverEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(RoverEntity)
public class RoverEntity: NSManagedObject {
    
}

extension RoverEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoverEntity> {
        return NSFetchRequest<RoverEntity>(entityName: "RoverEntity")
    }
    
    @NSManaged public var id: NSNumber
    @NSManaged public var name: String?
    @NSManaged public var pictures: NSSet?
    
}

// MARK: Generated accessors for pictures
extension RoverEntity {
    
    @objc(addPicturesObject:)
    @NSManaged public func addToPictures(_ value: PictureFromMarsEntity)
    
    @objc(removePicturesObject:)
    @NSManaged public func removeFromPictures(_ value: PictureFromMarsEntity)
    
    @objc(addPictures:)
    @NSManaged public func addToPictures(_ values: NSSet)
    
    @objc(removePictures:)
    @NSManaged public func removeFromPictures(_ values: NSSet)
    
}

extension RoverEntity : Identifiable {
    
    func update(with rover: Rover, photo: PictureFromMarsEntity) {
        
        id = NSNumber(value: rover.id)
        name = rover.name
        addToPictures(photo)
    }
}
