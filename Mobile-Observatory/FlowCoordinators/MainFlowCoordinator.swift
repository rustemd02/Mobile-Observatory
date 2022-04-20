//
//  MainFlowCoordinator.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import UIKit

final class MainFlowCoordinator: FlowCoordinatorProtocol {
    
    private let rootView: UIViewController
    private var tabBarView: UITabBarController

    init(rootView: UIViewController, tabBarView: UITabBarController) {
        self.rootView = rootView
        self.tabBarView = tabBarView
    }
    
    func start(animated: Bool) {
        let feedFlow = FeedFlowCoordinator(rootController: self)
        feedFlow.start(animated: true)
        let savedPostsFlow = SavedPostsFlowCoordinator(rootController: self)
        savedPostsFlow.start(animated: true)
    }
    
    func finish(animated: Bool) {
        
    }
}

extension MainFlowCoordinator: TabBarFlowCoordinatorProtocol {
    func appendView(_ view: UIViewController, item: UITabBarItem) {
        let navigationController = UINavigationController(rootViewController: view)
        item.tag = tabBarView.children.count
        navigationController.tabBarItem = item
        tabBarView.addChild(navigationController)
    }
}
