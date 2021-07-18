//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 18/07/21.
//

import Foundation

class SettingsViewModel {
  
  let storageManager: DataManager
  init(_ storageManager: DataManager) {
    self.storageManager = storageManager
  }
  
  func resetCities() {
    storageManager.deleteObjects(LocationEntity.self)
  }
}
