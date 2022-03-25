//
//  KeyWordEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 20.03.2022.
//
//

import Foundation
import CoreData

@objc(KeyWordEntity)
public class KeyWordEntity: NSManagedObject {

}

extension KeyWordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeyWordEntity> {
        return NSFetchRequest<KeyWordEntity>(entityName: "KeyWordEntity")
    }

    @NSManaged public var keyWord: String?
    @NSManaged public var id: NSNumber
    @NSManaged public var searchResult: NSSet?

}

// MARK: Generated accessors for searchResult
extension KeyWordEntity {

    @objc(addSearchResultObject:)
    @NSManaged public func addToSearchResult(_ value: SearchResultEntity)

    @objc(removeSearchResultObject:)
    @NSManaged public func removeFromSearchResult(_ value: SearchResultEntity)

    @objc(addSearchResult:)
    @NSManaged public func addToSearchResult(_ values: NSSet)

    @objc(removeSearchResult:)
    @NSManaged public func removeFromSearchResult(_ values: NSSet)

}

extension KeyWordEntity : Identifiable {

}
