//
//  ArticleEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData

@objc(ArticleEntity)
public class ArticleEntity: NSManagedObject {

}

extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var id: NSNumber
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var summary: String?
    @NSManaged public var picture: Data?
    @NSManaged public var articleUrl: String?
    @NSManaged public var newsSite: String?

}

extension ArticleEntity : Identifiable {

}
