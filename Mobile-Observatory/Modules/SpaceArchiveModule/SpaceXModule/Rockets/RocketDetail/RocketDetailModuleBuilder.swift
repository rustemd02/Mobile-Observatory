//
//  RocketDetailModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 24.05.2022.
//

import Foundation
import UIKit

class RocketDetailModuleBuilder {
    func build() -> RocketDetailViewController {
        let interactor = RocketDetailInteractor()
        let presenter = RocketDetailPresenter(interactor: interactor)
        let viewController = RocketDetailViewController(output: presenter)
        presenter.view = viewController as? RocketDetailViewControllerInput
        return viewController
    }
}
