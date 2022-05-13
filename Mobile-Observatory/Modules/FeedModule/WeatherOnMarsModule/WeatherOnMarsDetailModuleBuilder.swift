//
//  WeatherOnMarsModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation
import UIKit

class WeatherOnMarsDetailModuleBuilder {
    func build() -> WeatherOnMarsDetailViewController {
        let interactor = WeatherOnMarsDetailInteractor()
        let presenter = WeatherOnMarsDetailPresenter(interactor: interactor)
        let viewController = WeatherOnMarsDetailViewController(output: presenter)
        presenter.view = viewController as? WeatherOnMarsDetailViewControllerInput
        return viewController
    }
}
