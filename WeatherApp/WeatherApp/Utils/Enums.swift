//
//  Enums.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 17/07/21.
//

import UIKit

enum UnitSystem: Int {
  case metric
  case imperial
  
  var value: String {
    return "\(self)"
  }
  
  var tempUnit: String {
    switch self {
    case .metric:
      return "ºC"
    case .imperial:
      return "ºF"
    }
  }
  
  var windSpeedUnit: String {
    switch self {
    case .metric:
      return " m/s"
    case .imperial:
      return " mph"
    }
  }
}

enum WeatherIcon: String {
  case clearDay = "01d"
  case clearNight = "01n"
  case partialCloudyDay = "02d"
  case partialCloudyNight = "02n"
  case cloudyDay = "03d"
  case cloudyNight = "03n"
  case heavyCloud = "04d"
  case heavyRain = "10d"
  case lightRain = "9d"
  case thunderstorm = "11d"
  case rain = ""
  case windy = "50d"
  case snow = "13d"
  case fog = "50n"
  
  var icon: UIImage {
    switch self {
    case .clearDay:
      return #imageLiteral(resourceName: "sun")
    case .clearNight:
      return #imageLiteral(resourceName: "moon_and_stars")
    case .partialCloudyDay:
      return #imageLiteral(resourceName: "partly_cloudy_day")
    case .partialCloudyNight:
      return #imageLiteral(resourceName: "partly_cloudy_night")
    case .cloudyDay, .cloudyNight, .heavyCloud:
      return #imageLiteral(resourceName: "cloudy")
    case .heavyRain:
      return #imageLiteral(resourceName: "heavy_rain")
    case .lightRain:
      return #imageLiteral(resourceName: "light_rain")
    case .rain:
      return #imageLiteral(resourceName: "moderate_rain")
    case .thunderstorm:
      return #imageLiteral(resourceName: "storm")
    case .fog:
      return #imageLiteral(resourceName: "fog")
    case .windy:
      return #imageLiteral(resourceName: "windy")
    case .snow:
      return #imageLiteral(resourceName: "light_snow")
    }
  }
}
