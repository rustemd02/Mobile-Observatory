//
//  SpaceArchiveFlowCoordinator.swift
//  Mobile-Observatory
//
//  Created by Рустем on 12.05.2022.
//

import Foundation
import UIKit

final class SpaceArchiveFlowCoordinator: FlowCoordinatorProtocol {
    
    private let rootController: TabBarFlowCoordinatorProtocol
    
    private weak var spaceArchiveScreenView: UIViewController?
    private weak var detailInfoScreenView: UIViewController?
    
    init(rootController: TabBarFlowCoordinatorProtocol) {
        self.rootController = rootController
    }
    
    func start(animated: Bool) {
        let tabBarItem: UITabBarItem = UITabBarItem()
        tabBarItem.title = "База знаний"
        tabBarItem.image = UIImage(systemName: "magnifyingglass")
        rootController.appendView(SpaceArchiveModuleBuilder().build(), item: tabBarItem)
    }
    
    func finish(animated: Bool) {
        
    }
    
    
}
