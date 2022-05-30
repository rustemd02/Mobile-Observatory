//
//  SearchResultInteractor.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 28.05.2022.
//

import Foundation
import UIKit

protocol SearchResultInteractorProtocol {
    
}

class SearchResultInteractor: SearchResultInteractorProtocol {
    
    private let imageService: ImageByUrlService = ImageByUrlService.shared
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        imageService.getImageByUrl(url: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
}
