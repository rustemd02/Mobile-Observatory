//
//  LaunchesOverviewModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 03.06.2022.
//

import Foundation
import UIKit

class LaunchesOverviewModuleBuilder {
    func build() -> LaunchesOverviewViewController {
        let interactor = LaunchesOverviewInteractor()
        let presenter = LaunchesOverviewPresenter(interactor: interactor)
        let viewController = LaunchesOverviewViewController(output: presenter)
        presenter.view = viewController as? LaunchesOverviewViewControllerInput
        return viewController
    }
}
