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
        pictureURL = pictureOfDay.imageUrl
        
        var uiImage: UIImage = UIImage()
        
        ImageByUrlService.shared.getImageByUrl(url: pictureOfDay.imageUrl){
            image in
            do{
                uiImage = try image.get()
            }catch let error {
                print("Error: \(error)")
            }
        }
        let imageUrl = URL.init(string: pictureOfDay.imageUrl)
        let localPath = LocalFilesService.shared.saveImage(image: uiImage, name: imageUrl!.lastPathComponent)
        pictureLocalPath = localPath?.absoluteString
    }
    
    func convertToFeedEntity() -> PictureOfDay {
         var pictureOfDay = PictureOfDay(uuid: nil,
                            date: date!,
                            description: descr!,
                            title: title!,
                            imageUrl: pictureURL ?? "",
                            imageLocalPath: pictureLocalPath)
        pictureOfDay.isSaved = true
        return pictureOfDay
    }
}
