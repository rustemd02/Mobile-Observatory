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
        rootController.appendView(SavedPostsModuleBuilder().build())
    }

    func finish(animated: Bool) {
        savedPostsScreenView = nil
    }
}
