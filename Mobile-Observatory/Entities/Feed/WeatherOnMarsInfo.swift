//
//  WeatherPost.swift
//  Mobile-Observatory
//
//  Created by Рустем on 28.02.2022.
//

import Foundation

struct WeatherOnMarsInfo: Decodable {
    
    var id: Int?
    var sol: Int
    var earthDate: Date
    var minTemp: Int
    var maxTemp: Int
    var pressure: Int
    var pressureString: String
    var atmoOpacity: String
    var monthOnMars: String
    
    enum CodingKeys: String, CodingKey {
        case sol = "sol"
        case earthDate = "terrestrial_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case pressure = "pressure"
        case pressureString = "pressure_string"
        case atmoOpacity = "atmo_opacity"
        case monthOnMars = "season"
    }
    
    init(id: Int?, sol: Int, earthDate: Date, minTemp: Int, maxTemp: Int, pressure: Int, pressureString: String, atmoOpacity: String, monthOnMars: String) {
        self.id = id
        self.sol = sol
        self.earthDate = earthDate
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.pressure = pressure
        self.pressureString = pressureString
        self.atmoOpacity = atmoOpacity
        self.monthOnMars = monthOnMars
    }

}

