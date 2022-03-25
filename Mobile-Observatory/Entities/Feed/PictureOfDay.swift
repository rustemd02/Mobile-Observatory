//
//  PictureOfDayPost.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.02.2022.
//

import Foundation
import UIKit

struct PictureOfDay: Decodable {
    var date: Date
    var description: String
    var title: String
    var imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case description = "explanation"
        case imageUrl = "url"
        case title = "title"
        
    }
}
