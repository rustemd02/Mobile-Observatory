//
//  ArticleEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData
import UIKit

public class ArticleEntity: NSManagedObject {

}

extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var id: NSNumber
    @NSManaged public var articleUrl: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var newsSite: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var pictureURL: String?
    @NSManaged public var pictureLocalPath: String?

}

extension ArticleEntity : Identifiable {

    func update(with article: Article) {
        articleUrl = article.articleUrl
        createdAt = article.createdAt
        newsSite = article.newsSite
        summary = article.summary
        title = article.title
        pictureURL = article.pictureUrl
        
        var uiImage: UIImage? = nil
        
        ImageByUrlService.shared.getImageByUrl(url: article.pictureUrl){
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
        
        let imageUrl = URL.init(string: article.pictureUrl)
        let localPath = LocalFilesService.shared.saveImage(image: uiImage!, name: imageUrl!.lastPathComponent)
        pictureLocalPath = localPath?.relativeString
    }
    
    func convertToFeedEntity() -> Article {
        // swiftlint:disable:next force_cast
        return Article(id: Int(truncating: id),
                       title: title!,
                       createdAt: createdAt!,
                       summary: summary!,
                       pictureUrl: pictureURL ?? "",
                       pictureLocalPath: pictureLocalPath,
                       articleUrl: articleUrl ?? "",
                       newsSite: newsSite!)
    }
}
