//
//  Asteroids.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 31.05.2022.
//

import Foundation
import UIKit

// MARK: - Asteriod
struct Asteroids: Codable {
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

// MARK: - NearEarthObject
struct NearEarthObject: Codable {
    let id, name: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
    }
}

// MARK: - CloseApproachDatum
struct CloseApproachDatum: Codable {
    let closeApproachDate: String
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance

    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
    }
}

// MARK: - MissDistance
struct MissDistance: Codable {
    let kilometers: String
}

// MARK: - RelativeVelocity
struct RelativeVelocity: Codable {
    let kilometersPerSecond: String

    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
    }
}

// MARK: - EstimatedDiameter
struct EstimatedDiameter: Codable {
    let meters: Feet
}

// MARK: - Feet
struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}
