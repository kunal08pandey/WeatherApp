//
//  AddLocationViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import Foundation
import MapKit

class AddLocationViewModel: NSObject {
  
  let storageManager: DataManager
  init(_ storageManager: DataManager) {
    self.storageManager = storageManager
  }
  
  func saveLocation(_ location: MKPlacemark) {
    if let cityModel = storageManager.instantiate(CityModel.self) {
      let cityName = location.locality
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.latitude
      cityModel.setValue(cityName, forKey: "cityName")
      cityModel.setValue(latitude, forKey: "lat")
      cityModel.setValue(longitude, forKey: "lon")
      storageManager.saveContext()
    }
  }
  
}
