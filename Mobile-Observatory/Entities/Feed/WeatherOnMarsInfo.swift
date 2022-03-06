//
//  WeatherPost.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.02.2022.
//

import Foundation

struct WeatherOnMarsInfo {
    var sol: Int
    var earthDate: Date
    var minTemp: Int
    var maxTemp: Int
    var pressure: Int
    var pressureString: String
    var atmoOpacity: String
    var monthOnMars: Int
}
