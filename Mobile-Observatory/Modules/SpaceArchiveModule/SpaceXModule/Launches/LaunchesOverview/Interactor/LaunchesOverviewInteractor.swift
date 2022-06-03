//
//  LaunchesOverviewInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 03.06.2022.
//

import Foundation
protocol LaunchesOverviewInteractorProtocol {
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Launch
    func getLaunchesData() -> [Launch]
    func resetData()
}

class LaunchesOverviewInteractor: LaunchesOverviewInteractorProtocol {
    private var api = NetworkService.shared
    var launchesData = [Launch]()
    

    func getData(completion: @escaping () -> ()) {
        api.getSpaceXLaunches(period: "past") { [weak self] result in
            switch result {
            case .success(let launches):
                self?.launchesData = launches
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard !launchesData.isEmpty else {
            return 0
        }
        return launchesData.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Launch {
        return launchesData[indexPath.row]
    }
    
    func getLaunchesData() -> [Launch] {
        return launchesData
    }
    
    func resetData() {
        launchesData = []
    }
    
}


