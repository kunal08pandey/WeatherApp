//
//  APIService.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

protocol APIServiceProtocol {
  func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo?, Error>) -> Void)
  func getForecast<T>(_ cityName: String, completion:  @escaping (Result<[T]?, Error>) -> Void)
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
  var path: Path {
    return .forecast
  }
}

struct APIService: APIServiceProtocol {
  
  func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherInfo?, Error>) -> Void) {
    let responder = Responder(completion: completion)
    fetcher.fetch(request: WeatherRequest(lat: lat, lon: lon), responder: responder)
  }
  
  func getForecast<T>(_ cityName: String, completion: @escaping (Result<[T]?, Error>) -> Void) {
    
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
