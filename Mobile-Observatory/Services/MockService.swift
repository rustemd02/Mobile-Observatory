//
//  MockService.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation

class MockService{
    
    static let shared = MockService()
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
    
    func savePosts(){
    CoreDataService.shared.saveArticle(Article(id: 1, title: "Hello", createdAt: Date(milliseconds: 1), summary: "summary", pictureUrl: URL(fileURLWithPath: ""), pictureLocalPath: nil, articleUrl: URL(fileURLWithPath: ""), newsSite: "vigvamcev.com"))
    }
}
