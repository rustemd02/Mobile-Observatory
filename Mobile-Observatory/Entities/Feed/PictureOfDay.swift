//
//  PictureOfDayPost.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.02.2022.
//

import Foundation
import UIKit

struct PictureOfDay: Decodable {
    
    var uuid: UUID?
    var date: Date
    var description: String
    var title: String
    var imageUrl: URL
    var imageLocalPath: URL?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case description = "explanation"
        case imageUrl = "url"
        case title = "title"
        
    }
    
    init(uuid: UUID?, date: Date, description: String, title: String, imageUrl: URL, imageLocalPath: URL?) {
        self.uuid = uuid
        self.date = date
        self.description = description
        self.title = title
        self.imageUrl = imageUrl
        self.imageLocalPath = imageLocalPath
    }
}
