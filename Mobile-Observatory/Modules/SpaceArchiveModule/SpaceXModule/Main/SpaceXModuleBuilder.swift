//
//  SpaceXModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation
import UIKit

class SpaceXModuleBuilder {
    func build() -> SpaceXViewController {
        let interactor = SpaceXInteractor()
        let presenter = SpaceXPresenter(interactor: interactor)
        let viewController = SpaceXViewController(output: presenter)
        presenter.view = viewController as? SpaceXViewControllerInput
        return viewController
    }
}
