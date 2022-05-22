//
//  PlanetsPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 13.05.2022.
//

import Foundation

protocol PlanetsPresenterProtocol {
    
}

class PlanetsPresenter: PlanetsPresenterProtocol {
    private let interactor: PlanetsInteractorProtocol
    weak var view: PlanetsViewControllerInput?
    
    init(interactor: PlanetsInteractorProtocol) {
        self.interactor = interactor
    }
}

extension PlanetsPresenter: PlanetsViewControllerOutput {
    
}
