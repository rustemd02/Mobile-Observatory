//
//  SearchResultModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.05.2022.
//

import Foundation
import UIKit

class SearchResultModuleBuilder {
    func build() -> SearchResultDetailViewController {
        let interactor = SearchResultInteractor()
        let presenter = SearchResultPresenter(interactor: interactor)
        let viewController = SearchResultDetailViewController(output: presenter)
        presenter.view = viewController as? SearchResultDetailInput
        return viewController
    }
}
