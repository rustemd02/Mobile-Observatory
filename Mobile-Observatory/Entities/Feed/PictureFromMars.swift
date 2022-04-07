//
//  PictureFromMars.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation


struct PictureFromMars: Codable, Post {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, sol: Int
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

