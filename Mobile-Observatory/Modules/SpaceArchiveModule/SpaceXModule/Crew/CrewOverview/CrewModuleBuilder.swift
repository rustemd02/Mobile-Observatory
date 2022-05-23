//
//  CrewModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import Foundation
import UIKit

class CrewModuleBuilder {
    func build() -> CrewViewController {
        let interactor = CrewInteractor()
        let presenter = CrewPresenter(interactor: interactor)
        let viewController = CrewViewController(output: presenter)
        presenter.view = viewController as? CrewViewControllerInput
        return viewController
    }
}
