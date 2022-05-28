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

    init(){
        interactor = SavedPostsInteractor()
    }
}

extension SavedPostsPresenter: SavedPostsViewControllerOutput {
    
    func fetchSavedPosts() {
        interactor.getSavedPosts()
    }
    
    func viewDidLoad() {
        fetchSavedPosts()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Post {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
    func didSelectRow(at: Int) {
        
    }
    
    func didLoadData(){
        
    }
    
    func savePost(post: Post, indexPath: IndexPath?) {
        interactor.savePost(post: post, indexPath: indexPath)
    }
    
    
    func removePostFromSaved(post: Post, indexPath: IndexPath?) {
        interactor.removePostFromSaved(post: post, indexPath: indexPath)
    }
}
