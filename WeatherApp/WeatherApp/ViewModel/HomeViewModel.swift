//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import Foundation

class HomeViewModel {
  
  var cities: [LocationEntity] = []
  
  func numberOfItems() -> Int {
    return cities.count
  }
  
  func item(at index: Int) -> LocationEntity {
    return cities[index]
  }
  
  func cityName(at index: Int) -> String {
    return cities[index].locationName ?? ""
  }
  
  func fetchCities() {
    let storageManager = assembler.storageManager()
    cities = storageManager.fetch(LocationEntity.self)
  }
  
  func deleteCities(at indexPath: IndexPath) {
    let storageManager = assembler.storageManager()
    storageManager.deleteObject(cities[indexPath.row])
  }
  
}
