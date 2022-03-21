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
    let identifier, caption, image, version: String
    let centroidCoordinates: CentroidCoordinates
    let dscovrJ2000Position, lunarJ2000Position, sunJ2000Position: J2000Position
    let attitudeQuaternions: AttitudeQuaternions
    let date: String
    let coords: Coords

    enum CodingKeys: String, CodingKey {
        case identifier, caption, image, version
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
        case date, coords
    }
}

// MARK: - AttitudeQuaternions
struct AttitudeQuaternions: Codable {
    let q0, q1, q2, q3: Double
}

// MARK: - CentroidCoordinates
struct CentroidCoordinates: Codable {
    let lat, lon: Double
}

// MARK: - Coords
struct Coords: Codable {
    let centroidCoordinates: CentroidCoordinates
    let dscovrJ2000Position, lunarJ2000Position, sunJ2000Position: J2000Position
    let attitudeQuaternions: AttitudeQuaternions

    enum CodingKeys: String, CodingKey {
        case centroidCoordinates = "centroid_coordinates"
        case dscovrJ2000Position = "dscovr_j2000_position"
        case lunarJ2000Position = "lunar_j2000_position"
        case sunJ2000Position = "sun_j2000_position"
        case attitudeQuaternions = "attitude_quaternions"
    }
}

// MARK: - J2000Position
struct J2000Position: Codable {
    let x, y, z: Double
}

typealias PictureOfEarth = [PictureOfEarthElement]

