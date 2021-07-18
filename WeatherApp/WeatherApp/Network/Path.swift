//
//  Path.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

enum Path: String {
  
  static let appID = "appid"
  static let units = "units"
  
  static let baseURL = "https://api.openweathermap.org/data/2.5/"
  
  case weather = "weather"
  case forecast = "forecast/daily"
  
  var url: URL? {
    return URL(string: self.rawValue, relativeTo: URL(string: Self.baseURL))
  }
  
  var localUrl: URL? {
    switch self {
      case .weather:
        return Bundle.main.url(forResource: self.rawValue, withExtension: "json")
      case .forecast:
        return Bundle.main.url(forResource: self.rawValue, withExtension: "json")
    }
  }
  
  var value: String {
    return self.rawValue
  }
  
  var apiKey: String {
    return "4458b726f5ba41d425abcde55689b955"
  }
}
