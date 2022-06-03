//
//  PictureFromMars.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation

struct PictureFromMars: Codable, Post {
    var isSaved: Bool?
    
    var postType: PostType? = .pictureFromMars
    
    var photos: [Photo]
    
    init(photos: [Photo]) {
        self.photos = photos
    }
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

extension PictureFromMars: Equatable {
    
    static func == (larc: PictureFromMars, rarc: PictureFromMars) -> Bool {
            return
                larc.photos == rarc.photos
    }
}


// MARK: - Photo
struct Photo: Codable {
    
    var uuid: UUID?
    var id, sol: Int
    var imgSrc: String
    var imgLocalPath: String?
    var earthDate: Date
    var rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id, sol
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    init(uuid: UUID?, id: Int, sol: Int, imgSrc: String, imgLocalPath: String?, earthDate: Date, rover: Rover) {
        self.uuid = uuid
        self.id = id
        self.sol = sol
        self.imgSrc = imgSrc
        self.imgLocalPath = imgLocalPath
        self.earthDate = earthDate
        self.rover = rover
    }
}

extension Photo: Equatable {
    
    static func == (larc: Photo, rarc: Photo) -> Bool {
            return
                larc.sol == rarc.sol &&
                larc.earthDate == rarc.earthDate &&
                larc.rover == rarc.rover
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

extension Rover: Equatable {
    
    static func == (larc: Rover, rarc: Rover) -> Bool {
            return
                larc.id == rarc.id &&
                larc.name == rarc.name
    }
}
