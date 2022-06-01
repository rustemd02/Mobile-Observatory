//
//  AsteroidDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 31.05.2022.
//

import Foundation

class AsteroidDetailPresenter: AsteroidDetailOutput {
    
    private var interactor: AsteroidDetailInteractor
    var view: AsteroidDetailViewController?
    
    init(interactor: AsteroidDetailInteractor) {
        self.interactor = interactor
    }
}
