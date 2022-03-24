
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

