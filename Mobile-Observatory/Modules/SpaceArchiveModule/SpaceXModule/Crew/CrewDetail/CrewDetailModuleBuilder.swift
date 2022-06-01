//
//  CrewDetailModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import Foundation
import UIKit

class CrewDetailModuleBuilder {
    func build() -> CrewDetailViewController {
        let interactor = CrewDetailInteractor()
        let presenter = CrewDetailPresenter(interactor: interactor)
        let viewController = CrewDetailViewController(output: presenter)
        presenter.view = viewController as? CrewDetailViewControllerInput
        return viewController
    }
}
