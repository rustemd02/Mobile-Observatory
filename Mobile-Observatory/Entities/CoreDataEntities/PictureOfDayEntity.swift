//
//  PictureOfDayEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData
import UIKit

public class PictureOfDayEntity: NSManagedObject {
    
}

extension PictureOfDayEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureOfDayEntity> {
        return NSFetchRequest<PictureOfDayEntity>(entityName: "PictureOfDayEntity")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var descr: String?
    @NSManaged public var title: String?
    @NSManaged public var pictureURL: String?
    @NSManaged public var pictureLocalPath: String?
    @NSManaged public var date: Date?
    
}

extension PictureOfDayEntity : Identifiable {
    
    func update(with pictureOfDay: PictureOfDay) {
        
        title = pictureOfDay.title
        descr = pictureOfDay.description
        date = pictureOfDay.date
        pictureURL = pictureOfDay.imageUrl.absoluteString
        
        var uiImage: UIImage = UIImage()
        
        NetworkService.shared.getImageByUrl(url: pictureOfDay.imageUrl.absoluteString){
            image in
            do{
                uiImage = try image.get()
            }catch let error {
                print("Error: \(error)")
            }
        }
        let localPath = LocalFileManager.shared.saveImage(image: uiImage, name: pictureOfDay.imageUrl.lastPathComponent)
        pictureLocalPath = localPath?.absoluteString
    }
    
    func convertToFeedEntity() -> PictureOfDay {
        
        return PictureOfDay(uuid: id, date: date!, description: description, title: title!, imageUrl: URL.init(fileURLWithPath: pictureURL ?? ""), imageLocalPath: URL.init(fileURLWithPath: pictureLocalPath ?? ""))
    }
}
