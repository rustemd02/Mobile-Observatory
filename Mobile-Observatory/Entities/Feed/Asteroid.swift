//
//  Asteroid.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation

struct Asteroid {
    var id: Int
    var name: String
    var infoLink: URL
    var estimatedDiameter: Float
    var isHazardous: Bool
    var approachDate: Date
    var velocity: Float
    var missDistance: Float
}
