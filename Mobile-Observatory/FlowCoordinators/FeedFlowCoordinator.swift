//
//  FeedFlowCoordinator.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation
import UIKit

final class FeedFlowCoordinator: FlowCoordinatorProtocol {

    private let rootController: TabBarFlowCoordinatorProtocol

    private weak var feedScreenView: UIViewController?
    private weak var detailInfoScreenView: UIViewController?

    init(rootController: TabBarFlowCoordinatorProtocol) {
        self.rootController = rootController
    }

    func start(animated: Bool) {
        rootController.appendView(FeedModuleBuilder().build(), item: .featured)
    }

    func finish(animated: Bool) {
        feedScreenView = nil
        detailInfoScreenView = nil
    }
}
