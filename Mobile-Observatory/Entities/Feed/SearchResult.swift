//
//  SearchResult.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation
import UIKit

enum MediaType {
    case audio
    case video
    case image
    
    var description : String {
        switch self {
        case .audio: return "audio"
        case .video: return "video"
        case .image: return "image"
        }
    }
}

struct SearchResult {
    var nasaId: String
    
    var title: String
    var description: String
    var mediaType: MediaType
    var keyWords: [String]
    var createdAt: Date
    
    var videoURL: URL?
    var image: UIImage?
    var audioURL: URL?
    
    var credit: String?
    
}
