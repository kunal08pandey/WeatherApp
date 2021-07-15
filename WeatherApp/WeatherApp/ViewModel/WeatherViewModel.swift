//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import Foundation

class WeatherViewModel {
  
  var city: CityModel?
  var cityName: String = ""
  var iconUrl: String {
    if let icon = currentWeatherInfo?.weather.first?.icon {
      return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    return ""
  }
  var currentWeatherInfo: WeatherInfo?
  
  func getCurrentWeather(completion: @escaping (WeatherInfo?) -> Void) {
    guard let city = city else { return }
    self.cityName = city.cityName ?? ""
    let apiservice = assembler.apiService()
    apiservice.getCurrentWeather(lat: city.lat, lon: city.lon) { [weak self] result in
      switch result {
      case .success(let weatherInfo):
        self?.currentWeatherInfo = weatherInfo
        debugPrint("WeatherInfo: \(weatherInfo)")
        completion(weatherInfo)
      case .failure(let error):
        // handle Error
        debugPrint("Error : \(error)")
      }
    }
  }
  
}
