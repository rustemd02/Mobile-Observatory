//
//  SavedPostsFlowCoordinator.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

final class SavedPostsFlowCoordinator: FlowCoordinatorProtocol {

    private let rootController: TabBarFlowCoordinatorProtocol

    private weak var savedPostsScreenView: UIViewController?

    init(rootController: TabBarFlowCoordinatorProtocol) {
        self.rootController = rootController
    }

    func start(animated: Bool) {
        let presenter = SavedPostsPresenter()
        let viewController = SavedPostsViewController(output: presenter)
        presenter.view = viewController
        presenter.viewDidLoad()
        rootController.appendView(SavedPostsModuleBuilder().build(), item: .contacts)
    }

    func finish(animated: Bool) {
        savedPostsScreenView = nil
    }
}
