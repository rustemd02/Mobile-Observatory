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
    let api = NetworkService.shared
    var howManyArticlesToSkip = 0
    private var isFetching = false
    private var articleFetch = ArticleFetchController()

    
    func feedPrefetching(indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (articleFetch.articlesData.count - 3) && !isFetching {
                howManyArticlesToSkip+=10
                print(howManyArticlesToSkip)
                //loadArticles()
                break
            }
        }
    }
    
}
