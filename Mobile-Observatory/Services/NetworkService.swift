//
//  NetworkService.swift
//  Mobile-Observatory
//
//  Created by Рустем on 06.03.2022.
//

import Foundation
import Alamofire
import SwiftDate
import UIKit

// MARK: - Enum
enum NetworkError: Error {
    case inputError
    case noDataAvailable
    case processingError
    case serverUnavailable
}

class NetworkService {
    
    // MARK: - Properties
    static let shared = NetworkService()
    
    let nasaApiKey = "ZK8OvbXd3MxDwOD8RU2dyTCx9zT14eIjdVdTZmrI"
    
    let searchUrl = "https://images-api.nasa.gov/search?q="
    let nearbyAsteroidsFeedUrl = "https://api.nasa.gov/neo/rest/v1/feed?start_date="
    let picOfEarthUrl = "https://api.nasa.gov/EPIC/api/natural/date/"
    let getPicByNameUrl = "https://api.nasa.gov/EPIC/archive/natural/"
    let picFromMarsUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date="
    let picOfDayUrl = "https://api.nasa.gov/planetary/apod?api_key="
    let weatherApiUrl = "https://api.maas2.apollorion.com/"
    let spaceNewsArticlesUrl = "https://api.spaceflightnewsapi.net/v3/articles?_start="
    
    let planetsInfo = "https://dry-plains-91502.herokuapp.com/planets/"
    let spacexLaunches = "https://api.spacexdata.com/v5/launches" //latest next upcoming
    let spacexCrew = "https://api.spacexdata.com/v4/crew"
    let spacexRockets = "https://api.spacexdata.com/v4/rockets"
    
    // MARK: - Lifecycle
    private init(){}
    
    // MARK: - Functions
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
    
    
    func getNearbyAsteroids(date: Date, completion: @escaping(Result<Asteroids, NetworkError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)
        AF.request(nearbyAsteroidsFeedUrl + stringDate + "&api_key=" + nasaApiKey).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let asteroids = try jsonDecoder.decode(Asteroids.self, from: data)
                
                completion(.success(asteroids))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    //На вход подаётся количество постов N начиная с последнего, которые необходимо пропустить (по умолчанию 0 либо рандомное), по нажатию на кнопку далее или при бесконечной прокрутке счётчик увеличивается и происходит запрос с числом N+10
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
    func getPicOfDay(date: Date, completion: @escaping(Result<PictureOfDay, NetworkError>) -> Void) {
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
    func getPicFromMars(date: Date, completion: @escaping(Result<PictureFromMars, NetworkError>) -> Void) {
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
    
    //На вход подаётся дата, если по дате есть снимки в ответ возвращаются метаданные, по которым на стороне вызова метода получается изображение
    func getPicOfEarth(date: Date, completion: @escaping(Result<PictureOfEarth, NetworkError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)
        
        AF.request(picOfEarthUrl + stringDate + "?api_key=" + nasaApiKey).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let pictureOfEarth = try jsonDecoder.decode(PictureOfEarth.self, from: data)
                guard !pictureOfEarth.isEmpty else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                completion(.success(pictureOfEarth))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    
    //На вход подаётся поисковый запрос на английском языке
    func getSearchResults(searchQuery: String, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        AF.request(searchUrl + searchQuery).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let searchResults = try jsonDecoder.decode(SearchResult.self, from: data)
                completion(.success(searchResults))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    
    //Для метода getPicOfEarth
    func getImageByName(date: Date, imageName: String, completion: @escaping(Result<UIImage, NetworkError>) -> Void) {
        let year = date.year.description
        let month: String
        let day: String
        if date.month > 10 {
            month = date.month.description
        } else {
            month = "0" + date.month.description
        }
        
        if date.day > 10 {
            day = date.day.description
        } else {
            day = "0" + date.day.description
        }
        
        let completeUrl = getPicByNameUrl + year + "/" + month + "/" + day + "/png/" + imageName + ".png?api_key=" + nasaApiKey
        AF.request(completeUrl).response { (responseData) in
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
    
    func getSpaceXLaunches(period: String, completion: @escaping(Result<[Launch], NetworkError>) -> Void) {
        AF.request(spacexLaunches).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let launches = try jsonDecoder.decode([Launch].self, from: data)
                completion(.success(launches))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    func getSpaceXCrew(completion: @escaping(Result<[CrewMember], NetworkError>) -> Void) {
        AF.request(spacexCrew).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let crewMembers = try jsonDecoder.decode([CrewMember].self, from: data)
                completion(.success(crewMembers))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    func getSpaceXRockets(completion: @escaping(Result<[Rocket], NetworkError>) -> Void) {
        AF.request(spacexRockets).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let rockets = try jsonDecoder.decode([Rocket].self, from: data)
                completion(.success(rockets))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
    
    func getPlanetInfo(planet: String, completion: @escaping(Result<Planet, NetworkError>) -> Void) {
        AF.request(planetsInfo + planet).response { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let planet = try jsonDecoder.decode(Planet.self, from: data)
                completion(.success(planet))
            } catch {
                print(error)
                completion(.failure(.inputError))
            }
        }
    }
}
