//
//  Planet.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation

struct Planet {
    var name: String
    var moons: [String]
    var mass: Float
    var radius: Float
    var discoveredWhen: Date?
    var gravity: Float
    var bodyType: String
    
    init(name: String, moons: [String], mass: Float, radius: Float, discoveredWhen: Date?, gravity: Float, bodyType: String) {
        self.name = name
        self.moons = moons
        self.mass = mass
        self.radius = radius
        self.discoveredWhen = discoveredWhen
        self.gravity = gravity
        self.bodyType = bodyType
    }
}
