
import Foundation

// MARK: - PictureOfEarthElement

struct PictureOfEarthElement: Codable, Post {
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

