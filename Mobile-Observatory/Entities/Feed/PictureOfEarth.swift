////
////  PictureOfEarth.swift
////  Mobile-Observatory
////
////  Created by Рустем on 06.03.2022.
////
//
//import Foundation
//import UIKit
//
//struct PictureOfEarth: Decodable {
//    var date: Date
//    var imageUrl: String
//    var coords: Coords
//
//    enum CodingKeys: String, CodingKey {
//        case date = "date"
//        case imageUrl = "image"
//        case coords = "coords"
//
//    }
//}
//
//struct Coords: Decodable {
//    var centroidCoordinates: CentroidCoordinates
//
//    enum CodingKeys: String, CodingKey {
//        case centroidCoordinates = "centroid_coordinates"
//    }
//}
//
//struct CentroidCoordinates: Decodable {
//    var latitude: Double
//    var longtitude: Double
//
//    enum CodingKeys: String, CodingKey {
//        case latitude = "lat"
//        case longtitude = "lon"
//    }
//}



import Foundation

// MARK: - PictureOfEarthElement
struct PictureOfEarthElement: Codable {
    let imageUrl: String
    let centroidCoordinates: CentroidCoordinates
    let date: Date

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
        case centroidCoordinates = "centroid_coordinates"
        case date
    }
}

// MARK: - CentroidCoordinates
struct CentroidCoordinates: Codable {
    let lat, lon: Double
}

typealias PictureOfEarth = [PictureOfEarthElement]

