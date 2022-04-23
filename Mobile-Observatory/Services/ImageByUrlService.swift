//
//  ImageByUrlService.swift
//  Mobile-Observatory
//
//  Created by Рустем on 23.04.2022.
//

import Foundation
import UIKit
import Alamofire

class ImageByUrlService {
    
    static let shared = ImageByUrlService()
    
    private var api = NetworkService.shared
    
    
    func getImageByUrl(url: String, completion: @escaping(Result<UIImage, NetworkError>) -> Void) {
        AF.request(url).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(.processingError))
                return
            }
            completion(.success(image))
            
        }
    }
}
