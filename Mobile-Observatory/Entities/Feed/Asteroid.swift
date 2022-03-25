//
//  Asteroid.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation

struct NearEarthAsteroids: Decodable {
    var prevLink: URL
    var nextLink: URL
    var asteroids: [Asteroid]
}

struct Asteroid: Decodable {
    var id: Int
    var name: String
    var infoLink: URL
    var estimatedDiameter: Float
    var isHazardous: Bool
    var approachDate: Date
    var velocity: Float
    var missDistance: Float
}
