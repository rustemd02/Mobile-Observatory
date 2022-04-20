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
    
    func getArticlesData() -> [Article] {
        return interactor.getArticlesData()
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelectRow(at: Int) {
        
    }
    
    
    func getArticles(howManySkip: Int, completion: @escaping () -> ()) {
        return interactor.getArticles(howManySkip: howManySkip, completion: completion)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Article {
        return interactor.cellForRowAt(indexPath: indexPath)
    }
    
    func savePost(post: Post) {
        interactor.saveArticle(article: post as! Article)
    }
    
    func removePostFromSaved(post: Post) {
        interactor.removeArticleFromSaved(article: post as! Article)
    }
}
