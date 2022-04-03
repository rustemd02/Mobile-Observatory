//
//  SearchResult.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//


import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    var collection: Collection
    var links: [CollectionLink]?
    
    init(collection: Collection, links: [CollectionLink]?) {
        self.collection = collection
        self.links = links
    }
}

// MARK: - Collection
struct Collection: Codable {
    var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
}

// MARK: - Item
struct Item: Codable {
    var href: String
    var data: [Datum]
    var links: [ItemLink]
    
    init(href: String, data: [Datum], links: [ItemLink]) {
        self.href = href
        self.data = data
        self.links = links
    }
}

// MARK: - Datum
struct Datum: Codable {
    var title: String
    var photographer: String?
    var nasaID: String
    var dateCreated: Date
    var keywords: [String]?
    var mediaType: MediaType
    var datumDescription: String
    var album: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title, photographer
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case keywords
        case mediaType = "media_type"
        case datumDescription = "description"
        case album
    }
    
    init(title: String, photographer: String?, nasaID: String, dateCreated: Date, keywords: [String]?, mediaType: MediaType, datumDescription: String, album: [String]?) {
        self.title = title
        self.photographer = photographer
        self.nasaID = nasaID
        self.dateCreated = dateCreated
        self.keywords = keywords
        self.mediaType = mediaType
        self.datumDescription = datumDescription
        self.album = album
    }
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
    case audio = "audio"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    var href: String
    var render: MediaType?
    
    init(href: String, render: MediaType?) {
        self.href = href
        self.render = render
    }
}


// MARK: - CollectionLink
struct CollectionLink: Codable {
    var rel, prompt: String
    var href: String
    
    init(rel: String, prompt: String, href: String) {
        self.rel = rel
        self.prompt = prompt
        self.href = href
    }
}
