//
//  SearchResult.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 01.06.2022.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let items: [Item]
    let links: [CollectionLink]
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]?
}

// MARK: - Datum
struct Datum: Codable {
    let title, nasaID: String
    let mediaType: MediaType
    let keywords: [String]
    let dateCreated: Date
    let datumDescription: String
    let album: [String]?
    let photographer: String?

    enum CodingKeys: String, CodingKey {
        case title
        case nasaID = "nasa_id"
        case mediaType = "media_type"
        case keywords
        case dateCreated = "date_created"
        case datumDescription = "description"
        case album, photographer
    }
}

enum MediaType: String, Codable {
    case audio = "audio"
    case image = "image"
    case video = "video"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String
    let render: MediaType?
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}
