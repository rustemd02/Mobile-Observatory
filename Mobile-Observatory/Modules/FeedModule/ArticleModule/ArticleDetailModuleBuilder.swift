//
//  ArticleModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by Рустем on 20.04.2022.
//

import Foundation
import UIKit

class ArticleDetailModuleBuilder {
    func build() -> ArticleDetailViewController {
        let interactor = ArticleDetailInteractor()
        let presenter = ArticleDetailPresenter(interactor: interactor)
        let viewController = ArticleDetailViewController(output: presenter)
        presenter.view = viewController as? ArticleDetailViewControllerInput
        return viewController
    }
}
