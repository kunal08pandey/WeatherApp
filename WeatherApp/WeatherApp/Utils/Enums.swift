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
  case heavyCloudDay = "04d"
  case heavyCloudNight = "04n"
  case heavyRainDay = "10d"
  case heavyRainNight = "10n"
  case lightRainDay = "9d"
  case lightRainNight = "9n"
  case thunderstorm = "11d"
  case rain = ""
  case windyDay = "50d"
  case windyNight = "50n"
  case snowDay = "13d"
  case snowNight = "13n"
  case fog = "fog"
  
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
    case .cloudyDay, .cloudyNight, .heavyCloudDay, .heavyCloudNight:
      return #imageLiteral(resourceName: "cloudy")
    case .heavyRainDay, .heavyRainNight:
      return #imageLiteral(resourceName: "heavy_rain")
    case .lightRainDay, .lightRainNight:
      return #imageLiteral(resourceName: "light_rain")
    case .rain:
      return #imageLiteral(resourceName: "moderate_rain")
    case .thunderstorm:
      return #imageLiteral(resourceName: "storm")
    case .fog:
      return #imageLiteral(resourceName: "fog")
    case .windyDay, .windyNight:
      return #imageLiteral(resourceName: "windy")
    case .snowDay, .snowNight:
      return #imageLiteral(resourceName: "light_snow")
    }
  }
}

enum SocialLinks: Int {
  case facebook
  case twitter
  case linkedIn
  case github
  
  
  var url: URL? {
    switch self {
    case .facebook:
      return URL(string: "https://www.facebook.com/groups/270748973021342")
    case .twitter:
      return URL(string: "https://twitter.com/OpenWeatherMap")
    case .linkedIn:
      return URL(string: "https://www.linkedin.com/company/openweathermap/")
    case .github:
      return URL(string: "https://github.com/search?q=openweathermap&ref=cmdform")
    }
  }
}
