//
//  Presenter.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

class SavedPostsPresenter {

    weak var view: SavedPostsViewControllerInput?
    var interactor: SavedPostsInteractor
    private var isFetching = false
    var posts: [Post] = []

    init(){
        interactor = SavedPostsInteractor()
    }

    private func updateView() {
        posts = interactor.getSavedArticles()
        view?.updateView(with: posts)
    }
}

extension SavedPostsPresenter: SavedPostsViewControllerOutput {
    
    func fetchSavedArticles() {
        updateView()
    }
    
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
