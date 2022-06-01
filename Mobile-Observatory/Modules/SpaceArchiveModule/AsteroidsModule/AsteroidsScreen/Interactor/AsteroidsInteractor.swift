//
//  AsteroidsInteractor.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 30.05.2022.
//

import Foundation
import UIKit

protocol AsteroidsInteractorProtocol {
    func getNearAsteroids(date: Date, completion: @escaping () -> ())
    func didSelectRow(at: Int)
    func numberOfRowsInSection(section: Int) -> Int
    func asteroidForRowAt (indexPath: IndexPath) -> NearEarthObject
    func clearData()
}

class AsteroidsInteractor: AsteroidsInteractorProtocol {
    
    private let api = NetworkService.shared
    var asteroids: [NearEarthObject] = []
    
    func updateSearchResults(date: Date, completion: @escaping () -> ()) {
        self.asteroids = []
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getNearAsteroids(date: date, completion: dispatchGroup.leave)
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    func getNearAsteroids(date: Date, completion: @escaping () -> ()) {
        api.getNearbyAsteroids(date: date) { [weak self] result in
            switch result {
            case .success(let objects):
                var asteroids: [NearEarthObject] = []
                for asteroid in objects.nearEarthObjects.first?.value ?? [] {
                    var ast = asteroid
                    let random = Int.random(in: 1...5)
                    ast.image = UIImage(named: "asteroid" + random.description)
                    asteroids.append(ast)
                }
                self?.asteroids.append(contentsOf: asteroids)
                
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func didSelectRow(at: Int) {
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return asteroids.count
    }
    
    func asteroidForRowAt(indexPath: IndexPath) -> NearEarthObject {
        return asteroids[indexPath.row]
    }
    
    func clearData() {
        asteroids = []
    }
}
