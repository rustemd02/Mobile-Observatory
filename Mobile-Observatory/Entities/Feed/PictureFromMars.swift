//
//  PictureFromMars.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation


struct PictureFromMars: Codable {
    var photos: [Photo]
    
    init(photos: [Photo]) {
        self.photos = photos
    }
}

// MARK: - Photo
struct Photo: Codable {
    
    var uuid: UUID?
    var id, sol: Int
    var imgSrc: String
    var imgLocalPath: String?
    var earthDate: String
    var rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id, sol
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    init(uuid: UUID, id: Int, sol: Int, imgSrc: String, imgLocalPath: String?, earthDate: String, rover: Rover) {
        self.uuid = uuid
        self.id = id
        self.sol = sol
        self.imgSrc = imgSrc
        self.imgLocalPath = imgLocalPath
        self.earthDate = earthDate
        self.rover = rover
    }
}

// MARK: - Rover
struct Rover: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
