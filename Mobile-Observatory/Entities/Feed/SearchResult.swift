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

extension SearchResult: Equatable {
    
    static func == (larc: SearchResult, rarc: SearchResult) -> Bool {
            return
                larc.collection == rarc.collection &&
                larc.links == rarc.links
    }
}

// MARK: - Collection
struct Collection: Codable {
    let items: [Item]
}

extension Collection: Equatable {
    
    static func == (larc: Collection, rarc: Collection) -> Bool {
            return larc.items == rarc.items
    }
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]
}

extension Item: Equatable {
    
    static func == (larc: Item, rarc: Item) -> Bool {
            return
                larc.href == rarc.href &&
                larc.data == rarc.data &&
                larc.links == larc.links
    }
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

extension Datum: Equatable {
    
    static func == (larc: Datum, rarc: Datum) -> Bool {
            return
                larc.title == rarc.title &&
                larc.photographer == rarc.photographer &&
                larc.nasaID == larc.nasaID &&
                larc.dateCreated == larc.dateCreated &&
                larc.keywords == larc.keywords &&
                larc.mediaType == larc.mediaType &&
                larc.datumDescription == larc.datumDescription &&
                larc.album == larc.album
    }
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String
    let render: MediaType?
}

extension ItemLink: Equatable {
    
    static func == (larc: ItemLink, rarc: ItemLink) -> Bool {
            return
                larc.href == rarc.href &&
                larc.render == rarc.render
    }
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}

extension CollectionLink: Equatable {
    
    static func == (larc: CollectionLink, rarc: CollectionLink) -> Bool {
            return
                larc.rel == rarc.rel &&
                larc.prompt == rarc.prompt &&
                larc.href == rarc.href
    }
}
