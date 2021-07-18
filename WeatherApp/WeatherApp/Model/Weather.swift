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
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int = 0
    let id: Int = 0
    let country: String
    let sunrise, sunset: Int
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

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}
