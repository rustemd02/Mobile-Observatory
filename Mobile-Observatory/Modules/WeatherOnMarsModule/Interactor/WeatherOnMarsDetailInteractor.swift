//
//  WeatherOnMarsInteractor.swift
//  Mobile-Observatory
//
//  Created by Рустем on 22.04.2022.
//

import Foundation

protocol WeatherOnMarsDetailInteractorProtocol {
    func getWeatherInfo(sol: String, completion: @escaping (WeatherOnMarsInfo) -> Void)
}

class WeatherOnMarsDetailInteractor: WeatherOnMarsDetailInteractorProtocol {
    func getWeatherInfo(sol: String, completion: @escaping (WeatherOnMarsInfo) -> Void) {
        NetworkService.shared.getWeatherData(sol: sol) { result in
            switch result {
            case .success(let weatherInfo):
                completion(weatherInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
}
