//
//  AsteroidsPresenter.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 30.05.2022.
//

import Foundation

class AsteroidsPresenter {
    
    private let interactor: AsteroidsInteractorProtocol
    weak var view: AsteroidsViewController?
    
    init(interactor: AsteroidsInteractor) {
        self.interactor = interactor
    }
}

extension AsteroidsPresenter: AsteroidsOutput {
    func viewDidLoad() {
    }
    
    func didSelectRow(at: Int) {
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        interactor.numberOfRowsInSection(section: section)
    }
    
    func asteroidForRowAt(indexPath: IndexPath) -> NearEarthObject {
        interactor.asteroidForRowAt(indexPath: indexPath)
    }
    
    func getNearAsteroids(date: Date, completion: @escaping () -> ()) {
        interactor.getNearAsteroids(date: date, completion: completion)
    }
    
    func clearData() {
        interactor.clearData()
    }
}
