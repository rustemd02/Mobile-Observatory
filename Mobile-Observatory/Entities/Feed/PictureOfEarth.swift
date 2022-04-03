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
    var imageUrl: String
    var imageLocalPath: String?
    var centroidCoordinates: CentroidCoordinates
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
        case centroidCoordinates = "centroid_coordinates"
        case date
    }
    
    init(imageUrl: String, imageLocalPath: String?, centroidCoordinates: CentroidCoordinates, date: Date) {
        self.imageUrl = imageUrl
        self.imageLocalPath = imageLocalPath
        self.centroidCoordinates = centroidCoordinates
        self.date = date
    }
}

// MARK: - CentroidCoordinates
struct CentroidCoordinates: Codable {
    var lat, lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

typealias PictureOfEarth = [PictureOfEarthElement]

