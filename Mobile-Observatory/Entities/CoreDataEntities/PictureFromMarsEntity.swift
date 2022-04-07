//
//  PictureFromMarsEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData
import UIKit

public class PictureFromMarsEntity: NSManagedObject {

}

extension PictureFromMarsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureFromMarsEntity> {
        return NSFetchRequest<PictureFromMarsEntity>(entityName: "PictureFromMarsEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var pictureURL: String?
    @NSManaged public var pictureLocalPath: String?
    @NSManaged public var sol: NSNumber?
    @NSManaged public var collection: PicturesFromMarsCollectionEntity?
    @NSManaged public var rover: RoverEntity?

}

extension PictureFromMarsEntity : Identifiable {

    func update(with pictureFromMars: Photo, collection: PicturesFromMarsCollectionEntity) {
        
        date = Date.init(pictureFromMars.earthDate)
        pictureURL = pictureFromMars.imgSrc
        sol = pictureFromMars.sol as NSNumber
        self.collection = collection
        self.rover = rover
        
        var uiImage: UIImage? = nil
        
        NetworkService.shared.getImageByUrl(url: pictureFromMars.imgSrc){
            image in
            do{
                uiImage = try image.get()
            }catch let error {
                print("Error: \(error)")
            }
        }
        if(uiImage == nil){
            return
        }
        
        let localPath = LocalFileManager.shared.saveImage(image: uiImage!, name: pictureFromMars.imgSrc)
        pictureLocalPath = localPath?.absoluteString
    }
}