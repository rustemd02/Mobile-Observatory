//
//  Planet.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation

// MARK: - Planet
struct Planet: Codable {
    let id: Int
    let name, mass: String
    let diameter, density: Int
    let gravity, rotationPeriod, lengthOfDay, distanceFromSun: String
    let orbitalPeriod, orbitalVelocity: String
    let meanTemperature, numberOfMoons: Int

    enum CodingKeys: String, CodingKey {
        case id, name, mass, diameter, density, gravity
        case rotationPeriod = "rotation_period"
        case lengthOfDay = "length_of_day"
        case distanceFromSun = "distance_from_sun"
        case orbitalPeriod = "orbital_period"
        case orbitalVelocity = "orbital_velocity"
        case meanTemperature = "mean_temperature"
        case numberOfMoons = "number_of_moons"

    }
}


