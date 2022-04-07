//
//  Article.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation
import UIKit

struct Article: Decodable, Post {
    var id: Int
    var title: String
    var createdAt: Date
    var summary: String
    var pictureUrl: URL
    var pictureLocalPath: URL?
    var articleUrl: URL
    var newsSite: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case createdAt = "publishedAt"
        case summary = "summary"
        case pictureUrl = "imageUrl"
        case articleUrl = "url"
        case newsSite = "newsSite"
    }
    
    init(id: Int, title: String, createdAt: Date, summary: String, pictureUrl: URL, pictureLocalPath: URL?, articleUrl: URL, newsSite: String) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.summary = summary
        self.pictureUrl = pictureUrl
        self.pictureLocalPath = pictureLocalPath
        self.articleUrl = articleUrl
        self.newsSite = newsSite
    }
}
