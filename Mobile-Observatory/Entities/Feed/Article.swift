//
//  Article.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation
import UIKit

struct Article: Decodable {
    var id: Int
    var title: String
    var createdAt: Date
    var summary: String
    var picture: URL
    var articleUrl: URL
    var newsSite: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case createdAt = "publishedAt"
        case summary = "summary"
        case picture = "imageUrl"
        case articleUrl = "url"
        case newsSite = "newsSite"
    }
    
}
