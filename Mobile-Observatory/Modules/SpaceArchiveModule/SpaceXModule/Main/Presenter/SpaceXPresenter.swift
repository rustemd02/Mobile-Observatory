//
//  SpaceXPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation

protocol SpaceXPresenterProtocol {
    
}

class SpaceXPresenter: SpaceXPresenterProtocol {
    private let interactor: SpaceXInteractorProtocol
    weak var view: SpaceXViewControllerInput?
    
    init(interactor: SpaceXInteractorProtocol) {
        self.interactor = interactor
    }
}

extension SpaceXPresenter: SpaceXViewControllerOutput {
    
}
