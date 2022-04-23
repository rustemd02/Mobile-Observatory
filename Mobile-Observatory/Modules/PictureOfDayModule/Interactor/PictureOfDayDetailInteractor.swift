//
//  PictureOfDayInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation
import UIKit

protocol PictureOfDayDetailInteractorProtocol {
    func getImage(url: String, completion: @escaping (UIImage) -> Void)
    func getPicOfDay(date: Date, completion: @escaping (PictureOfDay) -> Void)
}

class PictureOfDayDetailInteractor: PictureOfDayDetailInteractorProtocol {
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
    
    func getPicOfDay(date: Date, completion: @escaping (PictureOfDay) -> Void) {
        NetworkService.shared.getPicOfDay(date: date) { result in
            switch result {
            case .success(let picOfDay):
                completion(picOfDay)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
