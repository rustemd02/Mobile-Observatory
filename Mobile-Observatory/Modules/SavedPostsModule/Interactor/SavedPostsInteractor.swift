//
//  SavedPostsInteractor.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation

protocol SavedPostsInteractorProtocol {
    func getSavedPosts() -> [Post]
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Post
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
}

class SavedPostsInteractor: SavedPostsInteractorProtocol {
    private var coreDataService: CoreDataService = CoreDataService.shared
    private var posts: [Post] = []
    
    func getSavedPosts() -> [Post] {
        posts = []
        posts.append(contentsOf: coreDataService.getAllArticles())
        posts.append(contentsOf: coreDataService.getAllWeatherOnMarsInfo())
        posts.append(contentsOf: coreDataService.getAllPicturesOfDay())
        return posts
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard !posts.isEmpty else {
            return 0
        }
        return posts.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Post {
        return posts[indexPath.row]
    }
    
    func savePost(post: Post){
        switch (post.postType) {
        case .article:
            coreDataService.saveArticle(post as! Article)
            break
        case .weatherOnMars:
            coreDataService.saveWeatherOnMarsInfo(post as! WeatherOnMarsInfo)
            break
        case .pictureOfDay:
            coreDataService.savePictureOfDay(post as! PictureOfDay)
            break
        case .pictureFromMars:
            coreDataService.savePictureFromMars(post as! PictureFromMars)
            break
        case .pictureOfEarth:
            coreDataService.savePictureOfEarth(post as! PictureOfEarthElement)
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
            coreDataService.deleteArticle(post as! Article)
            break
        case .weatherOnMars:
            coreDataService.deleteWeatherOnMarsInfo(post as! WeatherOnMarsInfo)
            break
        case .pictureOfDay:
            coreDataService.deletePictureOfDay(post as! PictureOfDay)
            break
        case .pictureFromMars:
            //            coreDataService.deletePictureFromMars(post)
            break
        case .pictureOfEarth:
            coreDataService.deletePictureOfEarth(post as! PictureOfEarthElement)
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
 
