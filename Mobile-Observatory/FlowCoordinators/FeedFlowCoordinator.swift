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
        let tabBarItem: UITabBarItem = UITabBarItem()
        tabBarItem.title = "Feed"
        tabBarItem.image = UIImage(systemName: "newspaper.fill")
        rootController.appendView(FeedModuleBuilder().build(), item: tabBarItem)
    }
    
    func finish(animated: Bool) {
        feedScreenView = nil
        detailInfoScreenView = nil
    }
}
