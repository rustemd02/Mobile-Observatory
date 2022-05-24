//
//  CrewDetailInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.05.2022.
//

import Foundation
import UIKit

protocol CrewDetailInteractorProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class CrewDetailInteractor: CrewDetailInteractorProtocol {
    private var api = NetworkService.shared
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
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

