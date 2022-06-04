//
//  LaunchModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 04.06.2022.
//

import Foundation
import UIKit

class LaunchModuleBuilder {
    func build() -> LaunchViewController {
        let interactor = LaunchInteractor()
        let presenter = LaunchPresenter(interactor: interactor)
        let viewController = LaunchViewController(output: presenter)
        presenter.view = viewController as? LaunchViewControllerInput
        return viewController
    }
}
