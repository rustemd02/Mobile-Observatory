//
//  SavedPostsFlowCoordinator.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

final class SavedPostsFlowCoordinator: FlowCoordinatorProtocol {

    private let rootController: MainFlowCoordinator

    private weak var savedPostsScreenView: UIViewController?

    init(rootController: MainFlowCoordinator) {
        self.rootController = rootController
    }

    func start(animated: Bool) {
        savedPostsScreenView = UIViewController()
    }

    func finish(animated: Bool) {
        savedPostsScreenView = nil
    }
}
