//
//  PlanetsModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 13.05.2022.
//

import Foundation
import UIKit

class PlanetsModuleBuilder {
    func build() -> PlanetsViewController {
        let interactor = PlanetsInteractor()
        let presenter = PlanetsPresenter(interactor: interactor)
        let viewController = PlanetsViewController(output: presenter)
        presenter.view = viewController as? PlanetsViewControllerInput
        return viewController
    }
}
