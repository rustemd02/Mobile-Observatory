//
//  PictureFromMarsDetailInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 05.05.2022.
//

import Foundation
import UIKit

protocol PictureFromMarsDetailInteractorProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicFromMars(date: Date, completion: @escaping (PictureFromMars) -> Void)
}

class PictureFromMarsDetailInteractor: PictureFromMarsDetailInteractorProtocol {
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
    func getPicFromMars(date: Date, completion: @escaping (PictureFromMars) -> Void) {
        NetworkService.shared.getPicFromMars(date: date) { result in
            switch result {
            case .success(let picFromMars):
                completion(picFromMars)
            case .failure(let error):
                print(error)
            }
        }
    }
}
