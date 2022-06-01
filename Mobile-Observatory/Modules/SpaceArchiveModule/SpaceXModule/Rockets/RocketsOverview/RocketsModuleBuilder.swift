//
//  RocketModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//

import Foundation
import UIKit

class RocketsModuleBuilder {
    func build() -> RocketsViewController {
        let interactor = RocketsInteractor()
        let presenter = RocketsPresenter(interactor: interactor)
        let viewController = RocketsViewController(output: presenter)
        presenter.view = viewController as? RocketsViewControllerInput
        return viewController
    }
}

