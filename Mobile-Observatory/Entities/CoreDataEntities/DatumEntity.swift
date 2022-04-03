//
//  DatumEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.03.2022.
//
//

import Foundation
import CoreData

public class DatumEntity: NSManagedObject {

}

extension DatumEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DatumEntity> {
        return NSFetchRequest<DatumEntity>(entityName: "DatumEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var photographer: String?
    @NSManaged public var descr: String?
    @NSManaged public var id: UUID?
    @NSManaged public var mediaType: String?
    @NSManaged public var nasaID: String?
    @NSManaged public var title: String?
    @NSManaged public var item: SearchResultItemEntity?
    @NSManaged public var keyWords: NSSet?
    @NSManaged public var album: NSSet?

}

// MARK: Generated accessors for keyWords
extension DatumEntity {

    @objc(addKeyWordsObject:)
    @NSManaged public func addToKeyWords(_ value: KeyWordEntity)

    @objc(removeKeyWordsObject:)
    @NSManaged public func removeFromKeyWords(_ value: KeyWordEntity)

    @objc(addKeyWords:)
    @NSManaged public func addToKeyWords(_ values: NSSet)

    @objc(removeKeyWords:)
    @NSManaged public func removeFromKeyWords(_ values: NSSet)

}

// MARK: Generated accessors for album
extension DatumEntity {

    @objc(addAlbumObject:)
    @NSManaged public func addToAlbum(_ value: AlbumEntity)

    @objc(removeAlbumObject:)
    @NSManaged public func removeFromAlbum(_ value: AlbumEntity)

    @objc(addAlbum:)
    @NSManaged public func addToAlbum(_ values: NSSet)

    @objc(removeAlbum:)
    @NSManaged public func removeFromAlbum(_ values: NSSet)

}

extension DatumEntity : Identifiable {

}
