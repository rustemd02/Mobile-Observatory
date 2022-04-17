//
//  Asteroid.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation

struct NearEarthAsteroids: Decodable {

    var prevLink: String
    var nextLink: String
    var asteroids: [Asteroid]
    
    init(prevLink: String, nextLink: String, asteroids: [Asteroid]) {
        self.prevLink = prevLink
        self.nextLink = nextLink
        self.asteroids = asteroids
    }
}

struct Asteroid: Decodable {
    
    var uuid: UUID?
    var id: Int
    var name: String
    var infoLink: String
    var estimatedDiameter: Float
    var isHazardous: Bool
    var approachDate: Date
    var velocity: Float
    var missDistance: Float
    
    init(uuid: UUID?, id: Int, name: String, infoLink: String, estimatedDiameter: Float, isHazardous: Bool, approachDate: Date, velocity: Float, missDistance: Float) {
        self.uuid = uuid
        self.id = id
        self.name = name
        self.infoLink = infoLink
        self.estimatedDiameter = estimatedDiameter
        self.isHazardous = isHazardous
        self.approachDate = approachDate
        self.velocity = velocity
        self.missDistance = missDistance
    }
}
