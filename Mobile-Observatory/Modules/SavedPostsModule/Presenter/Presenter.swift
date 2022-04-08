//
//  Presenter.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

class SavedPostsPresenter {

    weak var view: ViewControllerInput?
    var interactor: SavedPostsInteractor
    private var isFetching = false
    var posts: [Post] = []

    init(){
        interactor = SavedPostsInteractor()
    }

    private func updateView() {
        posts = CoreDataService.shared.getAllArticles()
        view?.updateView(with: posts)
    }
}

extension SavedPostsPresenter: ViewControllerOutput {
    func viewDidLoad() {
        updateView()
    }

    func didSelectRow(at: Int) {

    }
    
    func didLoadData(){
        
    }
}

extension SavedPostsPresenter: LoginPresenterInput {
    func start() -> UIViewController {
        UIViewController()
    }
}
