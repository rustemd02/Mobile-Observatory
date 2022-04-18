//
//  PictureOfDayPost.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.02.2022.
//

import Foundation
import UIKit

struct PictureOfDay: Decodable, Post {
    
    var uuid: UUID?
    var date: Date
    var description: String
    var title: String
    var imageUrl: String
    var imageLocalPath: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case description = "explanation"
        case imageUrl = "url"
        case title = "title"
        
    }
    
    init(uuid: UUID?, date: Date, description: String, title: String, imageUrl: String, imageLocalPath: String?) {
        self.uuid = uuid
        self.date = date
        self.description = description
        self.title = title
        self.imageUrl = imageUrl
        self.imageLocalPath = imageLocalPath
    }
}

extension PictureOfDay: Equatable {
    
    static func == (larc: PictureOfDay, rarc: PictureOfDay) -> Bool {
            return
                larc.date == rarc.date &&
                larc.description == rarc.description &&
                larc.title == rarc.title &&
                larc.imageUrl == rarc.imageUrl
    }
}
