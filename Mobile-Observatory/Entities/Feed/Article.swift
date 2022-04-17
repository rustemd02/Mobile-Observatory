//
//  Article.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation
import UIKit

struct Article: Decodable, Post {
    
    var uuid: UUID?
    var id: Int
    var title: String
    var createdAt: Date
    var summary: String
    var pictureUrl: String
    var pictureLocalPath: String?
    var articleUrl: String
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
    
    init(id: Int, title: String, createdAt: Date, summary: String, pictureUrl: String, pictureLocalPath: String?, articleUrl: String, newsSite: String) {
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

extension Article: Equatable {
    
    static func == (larc: Article, rarc: Article) -> Bool {
            return
                larc.title == rarc.title &&
                larc.createdAt == rarc.createdAt &&
                larc.summary == rarc.summary &&
                larc.pictureUrl == rarc.pictureUrl &&
                larc.articleUrl == rarc.articleUrl &&
                larc.newsSite == rarc.newsSite
    }
}
