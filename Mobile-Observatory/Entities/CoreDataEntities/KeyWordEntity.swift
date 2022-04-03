//
//  KeyWordEntity+CoreDataProperties.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 27.03.2022.
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

    @NSManaged public var id: UUID
    @NSManaged public var keyWord: String?
    @NSManaged public var datum: SearchResultEntity?

}

extension KeyWordEntity : Identifiable {

}
