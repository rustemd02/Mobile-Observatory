//
//  FeedPresenter.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol FeedPresenterProtocol {
    func feedPrefethcing(indexPaths: [IndexPath])
}

class FeedPresenter: FeedPresenterProtocol {
    
    private let interactor: FeedInteractorProtocol
    weak var view: FeedViewControllerInput?
    
    init(interactor: FeedInteractorProtocol) {
        self.interactor = interactor
    }
    
    func feedPrefethcing(indexPaths: [IndexPath]) {
        //
    }
}

extension FeedPresenter: FeedViewControllerOutput {
    
    func getPostsData() -> [Post] {
        return interactor.getPostsData()
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelectRow(at: Int) {
        
    }
    
    func resetFeed() {
        interactor.resetData()
    }
    
    func getData(completion: @escaping () -> ()) {
        return interactor.getData(completion: completion)
    }
    

    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Post {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
    func savePost(post: Post) {
        interactor.savePost(post: post)
    }
    
    func removePostFromSaved(post: Post) {
        interactor.removePostFromSaved(post: post)
    }
}
