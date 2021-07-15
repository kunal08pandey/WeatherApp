//
//  Weather.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

// MARK: - Weather
struct WeatherInfo: Codable {
    let coord: Coord
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
  
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    self.temp = try container.decode(Double.self, forKey: .temp)
//    self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
//    self.tempMin = try container.decode(Double.self, forKey: .tempMin)
//    self.tempMax = try container.decode(Double.self, forKey: .tempMax)
//    self.pressure = try container.decode(Int.self, forKey: .pressure)
//    self.humidity = try container.decode(Int.self, forKey: .humidity)
//  }
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int = 0
    let id: Int = 0
    let country: String
    let sunrise, sunset: Int
    let pod: Pod?
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
