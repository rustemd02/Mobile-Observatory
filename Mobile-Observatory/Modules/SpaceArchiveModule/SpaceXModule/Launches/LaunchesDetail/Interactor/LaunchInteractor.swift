//
//  LaunchInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 04.06.2022.
//

import Foundation
import UIKit

protocol LaunchInteractorProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
}

class LaunchInteractor: LaunchInteractorProtocol {
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

