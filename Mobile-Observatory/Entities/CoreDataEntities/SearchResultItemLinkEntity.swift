//
//  SearchResultItemLinkEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
//
//

import Foundation
import CoreData

@objc(SearchResultItemLinkEntity)
public class SearchResultItemLinkEntity: NSManagedObject {

}

extension SearchResultItemLinkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResultItemLinkEntity> {
        return NSFetchRequest<SearchResultItemLinkEntity>(entityName: "SearchResultItemLinkEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var href: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var item: SearchResultItemEntity?

}

extension SearchResultItemLinkEntity : Identifiable {

}
