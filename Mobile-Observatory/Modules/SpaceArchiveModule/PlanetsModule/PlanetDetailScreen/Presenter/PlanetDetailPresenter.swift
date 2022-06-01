//
//  PlanetDetailPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.05.2022.
//

import Foundation
import UIKit

protocol PlanetDetailPresenterProtocol {
}

class PlanetDetailPresenter: PlanetDetailPresenterProtocol {
    
    private let interactor: PlanetDetailInteractorProtocol
    weak var view: PlanetDetailViewControllerInput?
    
    init(interactor: PlanetDetailInteractorProtocol) {
        self.interactor = interactor
    }
   
}

extension PlanetDetailPresenter: PlanetDetailViewControllerOutput {
    func getPlanetInfo(planet: Planets, completion: @escaping (Planet) -> Void) {
        return interactor.getPlanetInfo(planet: planet, completion: completion)
    }
    
    
}
