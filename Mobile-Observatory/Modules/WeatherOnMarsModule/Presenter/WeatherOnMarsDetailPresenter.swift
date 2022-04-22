//
//  WeatherOnMarsPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation

protocol WeatherOnMarsDetailPresenterProtocol {
    
}

class WeatherOnMarsDetailPresenter: WeatherOnMarsDetailPresenterProtocol {
    private let interactor: WeatherOnMarsDetailInteractorProtocol
    weak var view: WeatherOnMarsDetailViewControllerInput?
    
    init(interactor: WeatherOnMarsDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    
}

extension WeatherOnMarsDetailPresenter: WeatherOnMarsDetailViewControllerOutput {
    
}
