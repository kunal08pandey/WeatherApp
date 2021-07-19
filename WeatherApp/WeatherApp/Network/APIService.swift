//
//  APIService.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

protocol APIServiceProtocol {
  func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo?, Error>) -> Void)
  func getForecast(lat: Double, lon: Double, completion:  @escaping (Result<WeatherForecast?, Error>) -> Void)
}

struct WeatherRequest: URLQueryRequest {
  
  let lat: Double
  let lon: Double
  
  var path: Path {
    return .weather
  }
  
  var parameters: Parameter {
    return ["lat": "\(lat)", "lon": "\(lon)"]
  }
}

struct ForecastRequest: URLQueryRequest {
  
  let lat: Double
  let lon: Double
  
  var path: Path {
    return .forecast
  }
  
  var parameters: Parameter {
    return ["lat": "\(lat)", "lon": "\(lon)", "cnt": "5"]
  }
}

struct APIService: APIServiceProtocol {
  
  func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo?, Error>) -> Void) {
    let responder = Responder(completion: completion)
    fetcher.fetch(request: WeatherRequest(lat: lat, lon: lon), responder: responder)
  }
  
  func getForecast(lat: Double, lon: Double, completion:  @escaping (Result<WeatherForecast?, Error>) -> Void) {
    let responder = Responder(completion: completion)
    fetcher.fetch(request: ForecastRequest(lat: lat, lon: lon), responder: responder)
  }
  
  
  let fetcher: Fetcher
  
  init(fetcher: Fetcher) {
    self.fetcher = fetcher
  }
  
//  func getAlbums(completion: @escaping (Result<[Album]?, Error>) -> Void) {
//    let responder = Responder(completion: completion)
//    fetcher.fetch(request: AlbumRequest(), responder: responder)
//  }
//  
//  func getUsers(completion:  @escaping (Result<[Person]?, Error>) -> Void) {
//    let responder = Responder(completion: completion)
//    fetcher.fetch(request: UserRequest(), responder: responder)
//  }
//  
//  func posts(completion:  @escaping (Result<[Article]?, Error>) -> Void) {
//    let responder = Responder(completion: completion)
//    fetcher.fetch(request: AlbumRequest(), responder: responder)
//  }
}
