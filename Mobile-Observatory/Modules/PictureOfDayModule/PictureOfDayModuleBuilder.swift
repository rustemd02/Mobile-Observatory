//
//  PictureOfDayModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation
import UIKit

class PictureOfDayDetailModuleBuilder {
    func build() -> PictureOfDayDetailViewController {
        let interactor = PictureOfDayDetailInteractor()
        let presenter = PictureOfDayDetailPresenter(interactor: interactor)
        let viewController = PictureOfDayDetailViewController(output: presenter)
        presenter.view = viewController as? PictureOfDayDetailViewControllerInput
        return viewController
    }
}
