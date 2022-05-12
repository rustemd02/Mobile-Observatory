//
//  Rocket.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation

// MARK: - Rocket
struct Rocket: Codable {
    let height, diameter: Double
    let mass: Double
    let flickrImages: [String]
    let name, type: String
    let active: Bool
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    let wikipedia: String
    let rocketDescription, id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case flickrImages = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia
        case rocketDescription = "description"
        case id
    }
}
