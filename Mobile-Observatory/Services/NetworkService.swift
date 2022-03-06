//
//  NetworkService.swift
//  Mobile-Observatory
//
//  Created by Рустем on 01.03.2022.
//

import Foundation

class NetworkService {
    // MARK: - Enum
    
    enum NetworkError: Error {
        case inputError
        case noDataAvailable
        case processingError
        case serverUnavailable
    }
    
    // MARK: - Properties
    
    static let shared = NetworkService()
    let apiKey: String = "ZK8OvbXd3MxDwOD8RU2dyTCx9zT14eIjdVdTZmrI"
    let weatherApiUrl: String = "https://api.maas2.apollorion.com/"
    
    // MARK: - Lifecycle
    
    private init(){}
    
    // MARK: - Functions
    
    func getWeatherInfo(sol: String, completion: @escaping(Result<WeatherPost, NetworkError>) -> Void) {
        guard let url = URL(string: weatherApiUrl + sol) else {
            completion(.failure(.inputError))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                completion(.failure(.processingError))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                //let weatherInfo = try jsonDecoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: jsonData)
                completion(.success(weatherInfo.first!))
            } catch {
                completion(.failure(.noDataAvailable))
            }
            
        }
        dataTask.resume()
    }
}
