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
}

class ArticleDetailInteractor: ArticleDetailInteractorProtocol {
    
    let coreData = CoreDataService.shared
    
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
