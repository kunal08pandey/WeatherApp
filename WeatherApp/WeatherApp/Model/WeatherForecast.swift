//
//  Forecast.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import Foundation

// MARK: - WeatherForecast
struct WeatherForecast: Codable {
  let city: City
  let cod: String
  let message: Double
  let cnt: Int
  let list: [WeatherForecastDay]
}

// MARK: - City
struct City: Codable {
  let id: Int
  let name: String
  let coord: Coord
  let country: String
  let population, timezone: Int
}

// MARK: - List
struct WeatherForecastDay: Codable {
  let dt: Int
  let sunrise: Int?
  let sunset: Int?
  let temp: Temp?
  let feelsLike: FeelsLike?
  let pressure: Int = 0
  let humidity: Int?
  let weather: [Weather]
  let speed: Double?
  let deg: Int?
  let gust: Double?
  let clouds: Int = 0
  let pop: Double = 0
  let rain: Double = 0
  
  enum CodingKeys: String, CodingKey {
    case dt, sunrise, sunset, temp
    case feelsLike = "feels_like"
    case pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
  }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
  let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
  let day, min, max, night: Double
  let eve, morn: Double
}

// MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}
