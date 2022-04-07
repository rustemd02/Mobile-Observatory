//
//  SearchResultItemEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(SearchResultItemEntity)
public class SearchResultItemEntity: NSManagedObject {

}

extension SearchResultItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResultItemEntity> {
        return NSFetchRequest<SearchResultItemEntity>(entityName: "SearchResultItemEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var href: String?
    @NSManaged public var data: NSSet?
    @NSManaged public var links: NSSet?
    @NSManaged public var searchResult: SearchResultEntity?

}

// MARK: Generated accessors for data
extension SearchResultItemEntity {

    @objc(addDataObject:)
    @NSManaged public func addToData(_ value: SearchResultEntity)

    @objc(removeDataObject:)
    @NSManaged public func removeFromData(_ value: SearchResultEntity)

    @objc(addData:)
    @NSManaged public func addToData(_ values: NSSet)

    @objc(removeData:)
    @NSManaged public func removeFromData(_ values: NSSet)

}

// MARK: Generated accessors for links
extension SearchResultItemEntity {

    @objc(addLinksObject:)
    @NSManaged public func addToLinks(_ value: SearchResultItemLinkEntity)

    @objc(removeLinksObject:)
    @NSManaged public func removeFromLinks(_ value: SearchResultItemLinkEntity)

    @objc(addLinks:)
    @NSManaged public func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged public func removeFromLinks(_ values: NSSet)

}

extension SearchResultItemEntity : Identifiable {

}
