//
//  SearchResult.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//


import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let collection: Collection
    let links: [CollectionLink]?
}

// MARK: - Collection
struct Collection: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]
}

// MARK: - Datum
struct Datum: Codable {
    let title: String
    let photographer: String?
    let nasaID: String
    let dateCreated: Date
    let keywords: [String]?
    let mediaType: MediaType
    let datumDescription: String
    let album: [String]?

    enum CodingKeys: String, CodingKey {
        case title, photographer
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case keywords
        case mediaType = "media_type"
        case datumDescription = "description"
        case album
    }
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
    case audio = "audio"
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
