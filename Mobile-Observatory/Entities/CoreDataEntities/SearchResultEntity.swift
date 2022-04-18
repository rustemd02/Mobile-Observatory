//
//  SearchResultEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(SearchResultEntity)
public class SearchResultEntity: NSManagedObject {

}

extension SearchResultEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResultEntity> {
        return NSFetchRequest<SearchResultEntity>(entityName: "SearchResultEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var collectionLinks: NSSet?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for collectionLinks
extension SearchResultEntity {

    @objc(addCollectionLinksObject:)
    @NSManaged public func addToCollectionLinks(_ value: SearchResultCollectionLinkEntity)

    @objc(removeCollectionLinksObject:)
    @NSManaged public func removeFromCollectionLinks(_ value: SearchResultCollectionLinkEntity)

    @objc(addCollectionLinks:)
    @NSManaged public func addToCollectionLinks(_ values: NSSet)

    @objc(removeCollectionLinks:)
    @NSManaged public func removeFromCollectionLinks(_ values: NSSet)

}

// MARK: Generated accessors for items
extension SearchResultEntity {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: SearchResultItemEntity)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: SearchResultItemEntity)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension SearchResultEntity : Identifiable {
    
    func convertToFeedEntity() -> SearchResult {
        // swiftlint:disable:next force_cast
        let collection = Collection(items: items?.allObjects as! [Item])
        return SearchResult(collection: collection, links: collectionLinks?.allObjects as? [CollectionLink])
    }
}
