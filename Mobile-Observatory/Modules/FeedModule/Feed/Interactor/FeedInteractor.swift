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
    func savePost(post: Post, indexPath: IndexPath?)
    func removePostFromSaved(post: Post, indexPath: IndexPath?)
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
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getArticles {
            dispatchGroup.leave()
        }
        if !(postsData.contains(where: { post in
            post.postType == .weatherOnMars
        })) {
            dispatchGroup.enter()
            getWeatherOnMars(sol: "", completion: dispatchGroup.leave)
        }
        dispatchGroup.enter()
        getPicOfDay(completion: dispatchGroup.leave)
        dispatchGroup.enter()
        getPicFromMars(completion: dispatchGroup.leave)
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func getArticles(completion: @escaping () -> ()) {
        api.getArticles(postsToSkip: howManyArticlesToSkip) { [weak self] result in
            switch result {
            case .success(let articles):
                guard let posts = self?.postsData else { return }
                if (posts.isEmpty) {
                    for art in articles {
                        var article = art
                        if ((self?.coreData.containsArticle(date: article.createdAt)) == true) {
                            article.isSaved = true
                        }
                        self?.postsData.append(article)
                    }
                } else {
                    for art in articles {
                        var article = art
                        var alreadyLoaded: Bool = false
                        if (posts.contains(where: { post in
                            post as? Article == article
                        })) {
                            alreadyLoaded = true
                        }
                        if (!alreadyLoaded) {
                            if ((self?.coreData.containsArticle(date: article.createdAt)) == true) {
                                article.isSaved = true
                            }
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
            case .success(var picOfDay):
                var alreadyShown: Bool = false
                guard let posts = self?.postsData else { return }
                for post in posts {
                    guard let pic = post as? PictureOfDay else { continue }
                    if (pic == picOfDay) {
                        alreadyShown = true
                        break
                    }
                }
                if (!alreadyShown) {
                    if ((self?.coreData.containsPictureOfDay(date: picOfDay.date)) == true) {
                        picOfDay.isSaved = true
                    }
                    self?.postsData.append(picOfDay)
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getPicFromMars(completion: @escaping () -> ()) {
        api.getPicFromMars(date: lastFetchedDate) { [weak self] result in
            switch result {
            case .success(var picFromMars):
                if (picFromMars.photos.isEmpty) {
                    completion()
                    return
                }
                var alreadyShown: Bool = false
                guard let posts = self?.postsData else { return }
                for post in posts {
                    guard let pic = post as? PictureFromMars else { continue }
                    if (pic == picFromMars) {
                        alreadyShown = true
                        break
                    }
                }
                if (!alreadyShown) {
                    if ((self?.coreData.containsPictureFromMars(id: picFromMars.photos.first?.id ?? -1)) == true) {
                        picFromMars.isSaved = true
                    }
                    self?.postsData.append(picFromMars)
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
        
    }
    
    func savePost(post: Post, indexPath: IndexPath?){
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
        case .none:
            break
        }
        
        guard let indexPath = indexPath else {
            return
        }
        postsData[indexPath.row].isSaved = true
    }
    
    func removePostFromSaved(post: Post, indexPath: IndexPath?){
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
            coreData.deletePictureFromMars(post as! PictureFromMars)
            break
        case .pictureOfEarth:
            coreData.deletePictureOfEarth(post as! PictureOfEarthElement)
            break
        case .none:
            break
        }
        
        guard let indexPath = indexPath else {
            return
        }
        postsData[indexPath.row].isSaved = false
    }
}

