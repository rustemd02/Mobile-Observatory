//
//  RocketsInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//

import Foundation

protocol RocketsInteractorProtocol {
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Rocket
    func getCrewMemberData() -> [Rocket]
    func resetData()
}

class RocketsInteractor: RocketsInteractorProtocol {
    private var api = NetworkService.shared
    var rocketsData = [Rocket]()
    
    func getData(completion: @escaping () -> ()) {
        api.getSpaceXRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                self?.rocketsData = rockets
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard !rocketsData.isEmpty else {
            return 0
        }
        return rocketsData.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Rocket {
        return rocketsData[indexPath.row]
    }
    
    func getCrewMemberData() -> [Rocket] {
        return rocketsData
    }
    
    func resetData() {
        rocketsData = []
    }
    
}


