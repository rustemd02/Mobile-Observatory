//
//  SpaceArchiveModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation
import UIKit

class SpaceArchiveModuleBuilder {
    func build() -> SpaceArchiveViewController {
        let interactor = SpaceArchiveInteractor()
        let presenter = SpaceArchivePresenter(interactor: interactor)
        let viewController = SpaceArchiveViewController(output: presenter)
        presenter.view = viewController as? SpaceArchiveInput
        return viewController
    }
}
