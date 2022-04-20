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

extension Planet: Equatable {
    
    static func == (larc: Planet, rarc: Planet) -> Bool {
            return
                larc.name == rarc.name &&
                larc.moons == rarc.moons &&
                larc.mass == rarc.mass &&
                larc.radius == rarc.radius &&
                larc.discoveredWhen == rarc.discoveredWhen &&
                larc.gravity == rarc.gravity &&
                larc.bodyType == rarc.bodyType
    }
}
