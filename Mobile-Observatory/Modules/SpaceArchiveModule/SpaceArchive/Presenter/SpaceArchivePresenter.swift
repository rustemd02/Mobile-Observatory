//
//  SpaceArchivePresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation

protocol SpaceArchivePresenterProtocol {
    
}

class SpaceArchivePresenter: SpaceArchivePresenterProtocol {
    private let interactor: SpaceArchiveInteractorProtocol
    weak var view: SpaceArchiveViewControllerInput?
    
    init(interactor: SpaceArchiveInteractorProtocol) {
        self.interactor = interactor
    }
}

extension SpaceArchivePresenter: SpaceArchiveViewControllerOutput {
    
}
