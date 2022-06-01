//
//  CrewPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import UIKit

protocol CrewPresenterProtocol {
}

class CrewPresenter: CrewPresenterProtocol {
    
    private let interactor: CrewInteractorProtocol
    weak var view: CrewViewControllerInput?
    
    init(interactor: CrewInteractorProtocol) {
        self.interactor = interactor
    }
    
}

extension CrewPresenter: CrewViewControllerOutput {
    func resetData() {
        return interactor.resetData()
    }
    
    
    func getCrewMemberData() -> [CrewMember] {
        return interactor.getCrewMemberData()
    }
    
    
    func didSelectRow(at: Int) {
        
    }
    
    func getData(completion: @escaping () -> ()) {
        return interactor.getData(completion: completion)
    }
    

    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> CrewMember {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
}

