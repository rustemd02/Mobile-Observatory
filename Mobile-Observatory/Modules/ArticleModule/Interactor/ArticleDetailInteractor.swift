//
//  ArticleDetailInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 07.04.2022.
//

import Foundation
import UIKit

protocol ArticleDetailInteractorProtocol {
    func getImage(url: String, completion: @escaping(UIImage) -> Void)
    func savePost(post: Post)
    func removePostFromSaved(post: Post)
}

class ArticleDetailInteractor: ArticleDetailInteractorProtocol {
    
    let coreData = CoreDataService.shared
    
    func savePost(post: Post) {
        coreData.saveArticle(post as! Article)
    }
    
    func removePostFromSaved(post: Post) {
        coreData.deleteArticle(post as! Article)
    }
    
    func getImage(url: String, completion: @escaping(UIImage) -> Void) {
        ImageByUrlService.shared.getImageByUrl(url: url, completion: { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
    
        })
    }
    
    
    
}
