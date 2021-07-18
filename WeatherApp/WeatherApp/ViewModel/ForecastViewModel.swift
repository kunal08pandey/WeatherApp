//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 16/07/21.
//

import UIKit

class ForecastViewModel {
  
  var forecastList: [WeatherForecastDay] = []
  var city: LocationEntity?
  
  func fetchForecast(completion: @escaping () -> Void) {
    guard let city = city else { return }
    let apiService = assembler.apiService()
    apiService.getForecast(lat: city.lat, lon: city.lon) {  [weak self] result in
      switch result {
      case .success(let forecast):
        self?.forecastList = forecast?.list ?? []
        completion()
      case .failure(let error):
        debugPrint("Error Occured :\(error)")
      }
    }
  }
  
  func numberOfItems() -> Int {
    return forecastList.count
  }
  
  func time(at indexPath: IndexPath) -> String {
    let forecastDay = forecastList[indexPath.row]
    let dateTimestamp = Double(forecastDay.dt)
    let day  = Date(timeIntervalSince1970: dateTimestamp).day
    return day
  }
  
  func minTemp(at indexPath: IndexPath) -> String {
    let forecastDay = forecastList[indexPath.row]
    let min = forecastDay.temp?.min ?? 0
    return min.tempUnit
  }
  
  func maxTemp(at indexPath: IndexPath) -> String {
    let forecastDay = forecastList[indexPath.row]
    let max = forecastDay.temp?.max ?? 0
    return max.tempUnit
  }
  
  func humidity(at indexPath: IndexPath) -> String {
    let forecastDay = forecastList[indexPath.row]
    let humidity = forecastDay.humidity
    return humidity?.humidityUnit ?? ""
  }
  
  func icon(at indexPath: IndexPath) -> UIImage? {
    let forecastDay = forecastList[indexPath.row]
    if let icon = forecastDay.weather.first?.icon {
      return WeatherIcon(rawValue: icon)?.icon
    }
    return nil
  }
}
