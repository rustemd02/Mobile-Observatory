//
//  FeedInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol FeedInteractorProtocol {
    func feedPrefetching(indexPaths: [IndexPath])
    func getArticlesData() -> [Article]
    func getArticles(howManySkip: Int, completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Article
    func saveArticle(article: Article)
    func removeArticleFromSaved(article: Article)
}

class FeedInteractor: FeedInteractorProtocol {
    private var api = NetworkService.shared
    private var coreData = CoreDataService.shared
    var articlesData = [Article]()
    
    func getArticlesData() -> [Article] {
        return articlesData
    }
    
    func getArticles(howManySkip: Int, completion: @escaping () -> ()) {
        api.getArticles(postsToSkip: howManySkip) { [weak self] result in
            switch result {
            case .success(let articles):
                for article in articles {
                    self?.articlesData.append(article)
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard !articlesData.isEmpty else {
            return 0
        }
        return articlesData.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Article {
        return articlesData[indexPath.row]
    }
  
    
    func feedPrefetching(indexPaths: [IndexPath]) {
        //        for index in indexPaths {
        //            if index.row >= (articleFetch.articlesData.count - 3) && !isFetching {
        //                howManyArticlesToSkip+=10
        //                print(howManyArticlesToSkip)
        //                loadArticles()
        //                break
        //            }
        //        }
    }
    
    func saveArticle(article: Article) {
        coreData.saveArticle(article)
    }
    
    func removeArticleFromSaved(article: Article) {
        coreData.deleteArticle(article)
    }
    
}
