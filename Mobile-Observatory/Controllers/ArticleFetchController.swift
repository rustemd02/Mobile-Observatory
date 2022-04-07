//
//  ArticleFetchController.swift
//  Mobile-Observatory
//
//  Created by Рустем on 29.03.2022.
//

import Foundation

class ArticleFetchController {
    private var api = NetworkService.shared
    var articlesData = [Article]()
    
    
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
}
