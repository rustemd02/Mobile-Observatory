//
//  AsteroidDetailModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 31.05.2022.
//

import Foundation

class AsteroidDetailModuleBuilder {
    func build() -> AsteroidDetailViewController {
        let interactor = AsteroidDetailInteractor()
        let presenter = AsteroidDetailPresenter(interactor: interactor)
        let viewController = AsteroidDetailViewController(output: presenter)
        presenter.view = viewController
        return viewController
    }
}
