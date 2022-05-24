//
//  PlanetDetailInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.05.2022.
//
import Foundation
import UIKit

protocol PlanetDetailInteractorProtocol {
    func getPlanetInfo(planet: Planets, completion: @escaping (Planet) -> Void)
}

class PlanetDetailInteractor: PlanetDetailInteractorProtocol {
    private var api = NetworkService.shared
    
    
    func getPlanetInfo(planet: Planets, completion: @escaping (Planet) -> Void) {
        let stringPlanet = planet.enumToString()
        NetworkService.shared.getPlanetInfo(planet: stringPlanet) { result in
            switch result {
            case .success(let planet):
                completion(planet)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
