//
//  LaunchesOverviewPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 03.06.2022.
//

import UIKit

protocol LaunchesOverviewPresenterProtocol {
}

class LaunchesOverviewPresenter: LaunchesOverviewPresenterProtocol {
    
    private let interactor: LaunchesOverviewInteractorProtocol
    weak var view: LaunchesOverviewViewControllerInput?
    
    init(interactor: LaunchesOverviewInteractorProtocol) {
        self.interactor = interactor
    }
    
}

extension LaunchesOverviewPresenter: LaunchesOverviewViewControllerOutput {
    func resetData() {
        return interactor.resetData()
    }
    
    
    func getLaunchesData() -> [Launch] {
        return interactor.getLaunchesData()
    }
    
    
    func didSelectRow(at: Int) {
        
    }
    
    func getData(completion: @escaping () -> ()) {
        return interactor.getData(completion: completion)
    }
    

    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Launch {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
}


