//
//  PlanetDetailModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.05.2022.
//
import Foundation
import UIKit

class PlanetDetailModuleBuilder {
    func build() -> PlanetDetailViewController {
        let interactor = PlanetDetailInteractor()
        let presenter = PlanetDetailPresenter(interactor: interactor)
        let viewController = PlanetDetailViewController(output: presenter)
        presenter.view = viewController as? PlanetDetailViewControllerInput
        return viewController
    }
}
