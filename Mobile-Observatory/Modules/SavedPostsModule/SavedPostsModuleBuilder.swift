//
//  SavedPostsModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

final class SavedPostsModuleBuilder {

    func build() -> UIViewController {
        let presenter = SavedPostsPresenter()
        let viewController = SavedPostsViewController(output: presenter)
        presenter.view = viewController
        presenter.viewDidLoad()
        return viewController
    }
}
