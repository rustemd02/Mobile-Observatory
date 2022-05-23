//
//  CrewInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import Foundation
protocol CrewInteractorProtocol {
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> CrewMember
    func getCrewMemberData() -> [CrewMember]
    func resetData()
}

class CrewInteractor: CrewInteractorProtocol {
    private var api = NetworkService.shared
    var crewMemberData = [CrewMember]()
    
    func getData(completion: @escaping () -> ()) {
        api.getSpaceXCrew { [weak self] result in
            switch result {
            case .success(let crewMembers):
                self?.crewMemberData = crewMembers
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard !crewMemberData.isEmpty else {
            return 0
        }
        return crewMemberData.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CrewMember {
        return crewMemberData[indexPath.row]
    }
    
    func getCrewMemberData() -> [CrewMember] {
        return crewMemberData
    }
    
    func resetData() {
        crewMemberData = []
    }
    
}

