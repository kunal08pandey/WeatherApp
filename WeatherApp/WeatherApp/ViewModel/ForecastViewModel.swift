//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 16/07/21.
//

import Foundation

class ForecastViewModel {
  
  var forecastList: [Any] = []
  
  func numberOfItems() -> Int {
    return forecastList.count
  }
  
}
