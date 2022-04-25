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
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
    func resetData()
}

class FeedInteractor: FeedInteractorProtocol {
    
    private var api = NetworkService.shared
    private var coreData = CoreDataService.shared
    var howManyArticlesToSkip = 0
    var postsData = [Post]()
    var lastFetchedDate: Date = Date()
    
    func getPostsData() -> [Post] {
        return postsData
    }
    
    func getData(completion: @escaping () -> ()) {
        getArticles(completion: completion)
        if !(postsData.contains(where: { post in
            post.postType == .weatherOnMars
        })) {
            getWeatherOnMars(sol: "", completion: completion)
        }
        getPicOfDay(completion: completion)
    }
    
    private func getArticles(completion: @escaping () -> ()) {
        api.getArticles(postsToSkip: howManyArticlesToSkip) { [weak self] result in
            switch result {
            case .success(let articles):
                guard let posts = self?.postsData else { return }
                if (posts.isEmpty) {
                    for article in articles {
                        self?.postsData.append(article)
                    }
                } else {
                    for article in articles {
                        var alreadyLoaded: Bool = false
                        if (posts.contains(where: { post in
                            post as? Article == article
                        })) {
                            alreadyLoaded = true
                        }
                        if (!alreadyLoaded) {
                            self?.postsData.append(article)
                        }
                    }
                }
                
                self?.lastFetchedDate = articles.last?.createdAt ?? Date()
                self?.howManyArticlesToSkip += 10
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getWeatherOnMars(sol: String, completion: @escaping () -> ()) {
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
    
    private func getPicOfDay(completion: @escaping () -> ()) {
        api.getPicOfDay(date: lastFetchedDate) { [weak self] result in
            switch result {
            case .success(let picOfDay):
                var alreadyShown: Bool = false
                guard let posts = self?.postsData else { return }
                for post in posts {
                    guard let pic = post as? PictureOfDay else { continue }
                    if (pic == picOfDay) {
                        alreadyShown = true
                        break
                    }
                }
                if(!alreadyShown) {
                    self?.postsData.append(picOfDay)
                    completion()
                }
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
    
    func resetData(){
        howManyArticlesToSkip = 0
        lastFetchedDate = Date()
        postsData = []
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
    
    func savePost(post: Post){
        switch (post.postType) {
        case .article:
            coreData.saveArticle(post as! Article)
            break
        case .weatherOnMars:
            coreData.saveWeatherOnMarsInfo(post as! WeatherOnMarsInfo)
            break
        case .pictureOfDay:
            coreData.savePictureOfDay(post as! PictureOfDay)
            break
        case .pictureFromMars:
            coreData.savePictureFromMars(post as! PictureFromMars)
            break
        case .pictureOfEarth:
            coreData.savePictureOfEarth(post as! PictureOfEarthElement)
            break
        case .asteroid:
            break
        case .planet:
            break
        case .searchResult:
            break
        case .none:
            break
        }
    }
    
    func removePostFromSaved(post: Post){
        switch (post.postType) {
        case .article:
            coreData.deleteArticle(post as! Article)
            break
        case .weatherOnMars:
            coreData.deleteWeatherOnMarsInfo(post as! WeatherOnMarsInfo)
            break
        case .pictureOfDay:
            coreData.deletePictureOfDay(post as! PictureOfDay)
            break
        case .pictureFromMars:
            //            coreData.deletePictureFromMars(post)
            break
        case .pictureOfEarth:
            coreData.deletePictureOfEarth(post as! PictureOfEarthElement)
            break
        case .asteroid:
            break
        case .planet:
            break
        case .searchResult:
            break
        case .none:
            break
        }
    }
}

