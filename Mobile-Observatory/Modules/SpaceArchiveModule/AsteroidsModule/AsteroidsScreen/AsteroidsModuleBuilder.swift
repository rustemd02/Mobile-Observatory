//
//  AsteroidsModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 30.05.2022.
//

import Foundation
import UIKit

class AsteroidsModuleBuilder {
    func build() -> AsteroidsViewController {
        let interactor = AsteroidsInteractor()
        let presenter = AsteroidsPresenter(interactor: interactor)
        let viewController = AsteroidsViewController(output: presenter)
        presenter.view = viewController
        return viewController
    }
}
