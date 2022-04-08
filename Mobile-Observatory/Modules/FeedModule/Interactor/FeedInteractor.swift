//
//  FeedInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol FeedInteractorProtocol {
    func feedPrefetching(indexPaths: [IndexPath])
}

class FeedInteractor: FeedInteractorProtocol {
    private let networkService: NetworkService
    
    
    init() {
        networkService = NetworkService.shared
    }
    
    //    func getArticles(posts: Int) -> (Result<[Article], NetworkError>) {
    //        networkService.getArticles(postsToSkip: 0) { result in
    //            switch result {
    //            case .success(let articles):
    //                return articles
    //            case .failure(_):
    //                return nil
    //            }
    //        }
    //    }
    
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
    
}
