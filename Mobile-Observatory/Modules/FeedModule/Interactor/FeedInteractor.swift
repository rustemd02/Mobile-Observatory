//
//  FeedInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation

protocol FeedInteractorProtocol {
    func feedPrefetching(indexPaths: [IndexPath])
    func getPostsData() -> [Post]
    func getData(completion: @escaping () -> ())
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Post
    func saveArticle(article: Article)
    func removeArticleFromSaved(article: Article)
    func getHowManyArticlesToSkip() -> Int
    func setHowManyArticlesToSkip(howMany: Int)
}

class FeedInteractor: FeedInteractorProtocol {
    private var api = NetworkService.shared
    private var coreData = CoreDataService.shared
    var howManyArticlesToSkip = 0
    var postsData = [Post]()
    
    func getPostsData() -> [Post] {
        return postsData
    }
    
    func getHowManyArticlesToSkip() -> Int {
        return howManyArticlesToSkip
    }
    func setHowManyArticlesToSkip(howMany: Int) {
        howManyArticlesToSkip = howMany
    }
    
    func getData(completion: @escaping () -> ()) {
        getArticles(howManySkip: howManyArticlesToSkip, completion: completion)
        if !(postsData.contains(where: { post in
            post.postType == .weatherOnMars
        })) {
            getWeatherOnMars(sol: "", completion: completion)
        }
        
        
    }
    
    func getArticles(howManySkip: Int, completion: @escaping () -> ()) {
        api.getArticles(postsToSkip: howManySkip) { [weak self] result in
            switch result {
            case .success(let articles):
                for article in articles {
                    self?.postsData.append(article)
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWeatherOnMars(sol: String, completion: @escaping () -> ()) {
        api.getWeatherData(sol: sol) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.postsData.append(weatherData)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPicOfDay(date: Date, completion: @escaping () -> ()) {
        api.getPicOfDay(date: date) { [weak self] result in
            switch result {
            case .success(let picOfDay):
                self?.postsData.append(picOfDay)
                completion()
            case .failure(let error):
                print(error)
            }
        
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard !postsData.isEmpty else {
            return 0
        }
        return postsData.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Post {
        return postsData[indexPath.row]
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
