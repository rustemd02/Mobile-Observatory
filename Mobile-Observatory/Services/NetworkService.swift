//
//  NetworkService.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation
import Alamofire
import SwiftDate

enum NetworkError: Error {
    case inputError
    case noDataAvailable
    case processingError
    case serverUnavailable
}

class NetworkService {
    
    static let shared = NetworkService()
    
    let nasaApiKey = "ZK8OvbXd3MxDwOD8RU2dyTCx9zT14eIjdVdTZmrI"
    
    let searchUrl = "https://images-api.nasa.gov/search?q="
    let picFromMarsUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date="
    let picOfDayUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let weatherApiUrl = "https://api.maas2.apollorion.com/"
    let spaceNewsArticlesUrl = "https://api.spaceflightnewsapi.net/v3/articles?_start="

    
    private init(){}
    
    //На вход может подаваться конкретный сол, тогда выдаётся результат для него, иначе выдается погода на сегодня
    func getWeatherData(sol: String, completion: @escaping(Result<WeatherOnMarsInfo, NetworkError>) -> Void) {
        AF.request(weatherApiUrl + sol).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssz"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let weatherOnMarsInfo = try jsonDecoder.decode(WeatherOnMarsInfo.self, from: data)
                
                completion(.success(weatherOnMarsInfo))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    //На вход подаётся количество постов N начиная с последнего, которые необходимо пропустить (по умолчанию 0), по нажатию на кнопку далее или при бесконечной прокрутке счётчик увеличивается и происходит запрос с числом N+10
    func getArticles(postsToSkip: Int, completion: @escaping(Result<[Article], NetworkError>) -> Void) {
        AF.request(spaceNewsArticlesUrl + postsToSkip.description).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssz"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let articles = try jsonDecoder.decode([Article].self, from: data)
                completion(.success(articles))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    //Метод возвращает фото дня по данной на вход дате (по умолчанию - сегодня)
    func getPicOfDay (date: Date, completion: @escaping(Result<PictureOfDay, NetworkError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)
        
        AF.request(self.picOfDayUrl + nasaApiKey + "&date=" + stringDate).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let pictureOfDay = try jsonDecoder.decode(PictureOfDay.self, from: data)
                completion(.success(pictureOfDay))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }

    //Метод возвращает фото дня по данной на вход дате (по умолчанию - сегодня)
    func getPicFromMars (date: Date, completion: @escaping(Result<PictureFromMars, NetworkError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)
        
        AF.request(picFromMarsUrl + stringDate + "&api_key=" + nasaApiKey).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let picturesFromMars = try jsonDecoder.decode(PictureFromMars.self, from: data)
                completion(.success(picturesFromMars))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }

//    //TODO: переформатирование даты, координаты
//    func getPicOfEarth (completion: @escaping(Result<PictureOfDay, NetworkError>) -> Void) {
//        AF.request(picOfDayUrl + nasaApiKey).response { (responseData) in
//            guard let data = responseData.data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//            do {
//                let jsonDecoder = JSONDecoder()
//                let pictureOfDay = try jsonDecoder.decode(PictureOfDay.self, from: data)
//                completion(.success(pictureOfDay))
//            } catch {
//                completion(.failure(.inputError))
//            }
//        }
//    }
//
    
    //На вход подаётся поисковый запрос на английском языке
    func getSearchResults (searchQuery: String, completion: @escaping(Result<[SearchResult], NetworkError>) -> Void) {
        AF.request(searchUrl + searchQuery).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssz"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let searchResults = try jsonDecoder.decode([SearchResult].self, from: data)
                completion(.success(searchResults))
            } catch {
                completion(.failure(.inputError))
            }
        }
    }



}
