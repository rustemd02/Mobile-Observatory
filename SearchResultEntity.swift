//
//  SearchResultEntity+CoreDataClass.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.03.2022.
//
//

import Foundation
import CoreData


public class SearchResultEntity: NSManagedObject {

}

extension SearchResultEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResultEntity> {
        return NSFetchRequest<SearchResultEntity>(entityName: "SearchResultEntity")
    }

    @NSManaged public var nasaId: String?
    @NSManaged public var title: String?
    @NSManaged public var descr: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var videoURL: String?
    @NSManaged public var image: Data?
    @NSManaged public var audioURL: String?
    @NSManaged public var credit: String?
    @NSManaged public var keyWords: NSSet?

}

// MARK: Generated accessors for keyWords
extension SearchResultEntity {

    @objc(addKeyWordsObject:)
    @NSManaged public func addToKeyWords(_ value: KeyWordEntity)

    @objc(removeKeyWordsObject:)
    @NSManaged public func removeFromKeyWords(_ value: KeyWordEntity)

    @objc(addKeyWords:)
    @NSManaged public func addToKeyWords(_ values: NSSet)

    @objc(removeKeyWords:)
    @NSManaged public func removeFromKeyWords(_ values: NSSet)

}

extension SearchResultEntity : Identifiable {

}
