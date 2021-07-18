//
//  AppPreferences.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 17/07/21.
//

import Foundation

protocol AppPreferenceProtocol {
  
  static var unitSystems: UnitSystem { get set }
}

class AppPreferences: UserDefaults, AppPreferenceProtocol {
    
  private static let UnitSystems = "default.unitSystems"
  
  static var unitSystems: UnitSystem {
    set {
      standard.setValue(newValue.rawValue, forKey: UnitSystems)
    }
    get {
      guard let rawValue = standard.value(forKey: UnitSystems) as? Int,
            let unitSystem = UnitSystem(rawValue: rawValue) else { return .metric }
      return  unitSystem
    }
  }
  
  
}
