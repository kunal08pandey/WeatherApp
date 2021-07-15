//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import Foundation

class HomeViewModel {
  
  var cities: [CityModel] = []
  
  func numberOfItems() -> Int {
    return cities.count
  }
  
  func item(at index: Int) -> CityModel {
    return cities[index]
  }
  
  func cityName(at index: Int) -> String {
    return cities[index].title
  }
  
  func fetchCities() {
    let storageManager = StorageManager()
    cities = storageManager.fetch(CityModel.self)
  }
  
}
