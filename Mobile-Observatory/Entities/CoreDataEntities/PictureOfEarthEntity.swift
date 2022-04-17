//
//  PictureOfEarthEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData
import UIKit

public class PictureOfEarthEntity: NSManagedObject {
    
}

extension PictureOfEarthEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureOfEarthEntity> {
        return NSFetchRequest<PictureOfEarthEntity>(entityName: "PictureOfEarthEntity")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var date: Date?
    @NSManaged public var latitude: NSNumber
    @NSManaged public var longtitude: NSNumber
    @NSManaged public var pictureURL: String?
    @NSManaged public var pictureLocalPath: String?
    
}

extension PictureOfEarthEntity : Identifiable {
    
    func update(with pictureOfEarth: PictureOfEarthElement) {
        
        date = pictureOfEarth.date
        latitude = pictureOfEarth.centroidCoordinates.lat as NSNumber
        longtitude = pictureOfEarth.centroidCoordinates.lon as NSNumber
        pictureURL = pictureOfEarth.imageUrl
        
        var uiImage: UIImage? = nil
        
        NetworkService.shared.getImageByUrl(url: pictureOfEarth.imageUrl){
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
        
        let localPath = LocalFilesService.shared.saveImage(image: uiImage!, name: pictureOfEarth.imageUrl)?.path
        pictureLocalPath = localPath
    }
    
    func convertToFeedEntity() -> PictureOfEarthElement {
        let coordinates: CentroidCoordinates = CentroidCoordinates(lat: Double(truncating: latitude), lon: Double(truncating: longtitude))
        return PictureOfEarthElement(imageUrl: pictureURL!,
                                     imageLocalPath: pictureLocalPath!,
                                     centroidCoordinates: coordinates, date: date!)
    }
}
