//
//  SavedPostsModuleBuilder.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

final class SavedPostsModuleBuilder {

    func build(what: What) -> UIViewController {
        let presenter = Presenter(dataService: DataService())
        let viewConrtoller = ViewController(output: presenter)
        presenter.view = viewConrtoller
        return viewConrtoller
    }
}
