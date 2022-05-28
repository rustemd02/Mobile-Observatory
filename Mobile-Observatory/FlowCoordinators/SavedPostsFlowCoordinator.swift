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
        let tabBarItem: UITabBarItem = UITabBarItem()
        tabBarItem.title = "Сохранённые"
        tabBarItem.image = UIImage(systemName: "suit.heart.fill")
        savedPostsScreenView = SavedPostsModuleBuilder().build()
        rootController.appendView(savedPostsScreenView ?? SavedPostsModuleBuilder().build(), item: tabBarItem)
    }
    
    func finish(animated: Bool) {
        savedPostsScreenView = nil
    }
}
