//
//  FeedModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 08.04.2022.
//

import Foundation
import UIKit

class FeedModuleBuilder {
    func build() -> UIViewController {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(interactor: interactor)
        let viewController = FeedViewController(output: presenter)
        presenter.view = viewController as? ViewControllerInput
        return viewController
    }
}
