//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import UIKit

class WeatherViewModel {
  
  var city: CityModel?
  var cityName: String = ""
  var iconUrl: String {
    if let icon = currentWeatherInfo?.weather.first?.icon {
      return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    return ""
  }
  private var currentWeatherInfo: WeatherInfo?
  
  func getCurrentWeather(completion: @escaping () -> Void) {
    guard let city = city else { return }
    self.cityName = city.cityName ?? ""
    let apiservice = assembler.apiService()
    apiservice.getCurrentWeather(lat: city.lat, lon: city.lon) { [weak self] result in
      switch result {
      case .success(let weatherInfo):
        self?.currentWeatherInfo = weatherInfo
        completion()
      case .failure(let error):
        // handle Error
        debugPrint("Error : \(error)")
      }
    }
  }
  
  var sunriseTime: String {
    return currentWeatherInfo?.sunriseTime ?? ""
  }
  var sunsetTime: String {
    return currentWeatherInfo?.sunsetTime ?? ""
  }
  var currentTemprature: String {
    return currentWeatherInfo?.currentTemprature ?? ""
  }
  var minTemperature: String {
    return currentWeatherInfo?.minTemperature ?? ""
  }
  var maxTemperature: String {
    return currentWeatherInfo?.maxTemperature ?? ""
  }
  var humidity: String {
    return currentWeatherInfo?.humidity ?? ""
  }
  var atmosphericPressure: String {
    return currentWeatherInfo?.atmosphericPressure ?? ""
  }
  
  var windSpeed: String {
    return currentWeatherInfo?.windSpeed ?? ""
  }
  
  var icon: UIImage? {
    return currentWeatherInfo?.icon
  }
  
}

protocol WeatherModel {
  var sunriseTime: String { get }
  var sunsetTime: String { get }
  var currentTemprature: String { get }
  var minTemperature: String { get }
  var maxTemperature: String { get }
  var atmosphericPressure: String { get }
  var humidity: String { get }
  var windSpeed: String { get }
  var icon: UIImage? { get }
}

extension WeatherInfo: WeatherModel {
  var windSpeed: String {
    return wind.speed.windSpeedUnit
  }
  
  var sunriseTime: String {
    let timeStamp = TimeInterval(sys.sunrise)
    return Date(timeIntervalSince1970: timeStamp).time
  }
  
  var sunsetTime: String {
    let timeStamp = TimeInterval(sys.sunset)
    return Date(timeIntervalSince1970: timeStamp).time
  }
  
  var currentTemprature: String {
    return main.temp.tempUnit
  }
  
  var minTemperature: String {
    return main.tempMin.tempUnit
  }
  
  var maxTemperature: String {
    return main.tempMax.tempUnit
  }
  
  var atmosphericPressure: String {
    return main.pressure.pressureUnit
  }
  
  var humidity: String {
    return main.humidity.humidityUnit
  }
  
  var icon: UIImage? {
    if let icon = weather.first?.icon {
      return WeatherIcon(rawValue: icon)?.icon
    }
    return nil
  }
  
  
}
