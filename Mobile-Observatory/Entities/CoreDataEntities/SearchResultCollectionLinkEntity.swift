//
//  SearchResultCollectionLinkEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(SearchResultCollectionLinkEntity)
public class SearchResultCollectionLinkEntity: NSManagedObject {

}

extension SearchResultCollectionLinkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResultCollectionLinkEntity> {
        return NSFetchRequest<SearchResultCollectionLinkEntity>(entityName: "SearchResultCollectionLinkEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var rel: String?
    @NSManaged public var prompt: String?
    @NSManaged public var href: String?
    @NSManaged public var collection: SearchResultEntity?

}

extension SearchResultCollectionLinkEntity : Identifiable {

}
