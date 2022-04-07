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
        articleUrl = article.articleUrl.absoluteString
        createdAt = article.createdAt
        newsSite = article.newsSite
        summary = article.summary
        title = article.title
        pictureURL = article.pictureUrl.absoluteString
        
        var uiImage: UIImage? = nil
        
        NetworkService.shared.getImageByUrl(url: article.pictureUrl.absoluteString){
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
        
        let localPath = LocalFileManager.shared.saveImage(image: uiImage!, name: article.pictureUrl.lastPathComponent)
        pictureLocalPath = localPath?.absoluteString
    }
    
    func convertToFeedEntity() -> Article {
        
        return Article(id: Int(truncating: id), title: title!, createdAt: createdAt!, summary: summary!, pictureUrl: URL.init(fileURLWithPath: pictureURL ?? ""), pictureLocalPath: URL.init(string: pictureLocalPath!)!, articleUrl: URL.init(fileURLWithPath: articleUrl ?? ""), newsSite: newsSite!)
    }
}
