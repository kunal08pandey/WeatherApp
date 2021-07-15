//
//  CityModel.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import UIKit

extension CityModel: ModelLayer {
  
  var title: String {
    return cityName ?? ""
  }
  
  var image: UIImage? {
    return nil
  }
  
  var url: String {
    return ""
  }
  
  
}
