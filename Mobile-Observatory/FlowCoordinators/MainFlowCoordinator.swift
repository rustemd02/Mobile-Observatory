//
//  MainFlowCoordinator.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import UIKit

final class MainFlowCoordinator: FlowCoordinatorProtocol {

    private let rootView: UIViewController
    private var tabBarView: UITabBarController?

    init(rootView: UIViewController) {
        self.rootView = rootView
    }

    func start(animated: Bool) {
        let savedPostsFlow = SavedPostsFlowCoordinator(rootController: self)
        savedPostsFlow.start(animated: true)
    }

    func finish(animated: Bool) {
        
    }
}

extension MainFlowCoordinator: TabBarFlowCoordinatorProtocol {
    func appendView(_ view: UIViewController) {
        tabBarView?.addChild(view)
    }
}
