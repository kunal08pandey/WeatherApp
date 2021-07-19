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
  
  func saveLocation(_ title: String?, coordinate: CLLocationCoordinate2D) {
    if let cityModel = storageManager.instantiate(LocationEntity.self), let title = title {
      let cityName = title
      let latitude = coordinate.latitude
      let longitude = coordinate.longitude
      cityModel.setValue(cityName, forKey: "locationName")
      cityModel.setValue(latitude, forKey: "lat")
      cityModel.setValue(longitude, forKey: "lon")
      storageManager.saveContext()
    }
  }
  
  func search(_ searchText: String, region: MKCoordinateRegion, completion: @escaping ([MKMapItem]) -> Void) {
    let localRequest = MKLocalSearch.Request()
    localRequest.naturalLanguageQuery = searchText
    localRequest.region = region
    let search = MKLocalSearch(request: localRequest)
    search.start { response, _ in
      guard let response = response else { return completion([])}
      completion(response.mapItems)
    }
  }
}
