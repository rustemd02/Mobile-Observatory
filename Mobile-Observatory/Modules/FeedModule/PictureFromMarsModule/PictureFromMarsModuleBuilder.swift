//
//  PictureFromMarsModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import Foundation
import UIKit

class PictureFromMarsDetailModuleBuilder {
    func build() -> PictureFromMarsDetailViewController {
        let interactor = PictureFromMarsDetailInteractor()
        let presenter = PictureFromMarsDetailPresenter(interactor: interactor)
        let viewController = PictureFromMarsDetailViewController(output: presenter)
        presenter.view = viewController as? PictureFromMarsDetailViewControllerInput
        return viewController
    }
}
