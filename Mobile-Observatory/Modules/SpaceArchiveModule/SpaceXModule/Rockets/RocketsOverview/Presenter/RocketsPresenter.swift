//
//  RocketsPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//


import UIKit

protocol RocketsPresenterProtocol {
}

class RocketsPresenter: RocketsPresenterProtocol {
    
    private let interactor: RocketsInteractorProtocol
    weak var view: RocketsViewControllerInput?
    
    init(interactor: RocketsInteractorProtocol) {
        self.interactor = interactor
    }
    
}

extension RocketsPresenter: RocketsViewControllerOutput {
    func resetData() {
        return interactor.resetData()
    }
    
    
    func getRocketsData() -> [Rocket] {
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
    
    func cellForRowAt (indexPath: IndexPath) -> Rocket {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
}
